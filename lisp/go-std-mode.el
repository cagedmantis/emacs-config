;;; go-std-mode.el --- Develop the Go toolchain, runtime and stdlib  -*- lexical-binding: t; -*-

;;; Commentary:

;; A minor mode for working *on* Go -- cmd/compile, the runtime and the
;; standard library in the golang/go tree -- as opposed to writing programs
;; *in* Go.  It layers on top of `go-mode' and `lsp-mode'; it replaces
;; neither.
;;
;; The central problem it solves: when you edit $GOROOT/src/bytes/bytes.go,
;; every command you run must use the `go' binary built from *that tree*
;; ($GOROOT/bin/go), not whatever `go' happens to be first on your PATH.
;; Getting this wrong silently tests the wrong code, which is the classic way
;; to waste an afternoon.  `go-std-mode' makes the right toolchain the default
;; for every subprocess started from a buffer inside the tree.
;;
;;; Two kinds of repository
;;
;; The mode recognises two contexts and configures each differently:
;;
;;   goroot  The main Go tree: a directory containing src/make.bash.  This is
;;           a GOROOT, not a module in the usual sense.  Note it contains its
;;           own go.mod files (src/go.mod declares `module std',
;;           src/cmd/go.mod declares `module cmd'), so detecting it by
;;           searching upward for go.mod finds the wrong root.  We look for
;;           src/make.bash first, and only fall back to go.mod.
;;
;;   x-repo  A golang.org/x/* module (x/tools, x/perf, x/net, ...).  Ordinary
;;           modules, built with a released toolchain.  No GOROOT override --
;;           only GOBIN isolation, so `go install' here does not overwrite the
;;           binaries in your normal ~/go/bin.
;;
;;; Bootstrap toolchain vs. development toolchain
;;
;; These are different things and confusing them is a common error:
;;
;;   GOROOT_BOOTSTRAP  A *released, working* Go used to compile the tree.
;;                     src/make.bash needs it.  Set `go-std-goroot-bootstrap',
;;                     or leave it nil to let make.bash find one itself.
;;
;;   $GOROOT/bin/go    The toolchain you just built.  Everything else --
;;                     tests, benchmarks, builds -- uses this one.
;;
;; Helper tools (benchstat, toolstash, ...) are deliberately installed with a
;; *stable* Go, never with the development compiler: you install them
;; precisely so you can diagnose a development compiler that may be broken.
;;
;;; The core iteration loop
;;
;; Compiler or runtime change:
;;
;;   1. Edit src/cmd/compile/... or src/runtime/...
;;   2. `go-std-install-compiler' (C-c G c) -- `go install cmd/compile'.
;;      Seconds, not minutes.  Use this, not a full make.bash, in the loop.
;;      A runtime change needs no rebuild step; `go test' rebuilds it.
;;   3. `go-std-test-package' (C-c G t) or `go-std-test-runtime' (C-c G r).
;;   4. For a change that is supposed to be a no-op at the object-code level,
;;      `go-std-toolstash-compare' (C-c G K) proves it.
;;   5. Full `go-std-build-toolchain' (C-c G b, make.bash) only when you have
;;      changed something that make.bash itself depends on, or before you post
;;      a CL.  `go-std-build-all' (C-c G B, all.bash) runs the full test suite
;;      and takes many minutes.
;;
;; Standard library change:
;;
;;   1. Edit src/bytes/....  No toolchain rebuild is required -- `go test'
;;      compiles the package from source.
;;   2. `go-std-test-package' (C-c G t).
;;   3. Benchmark: baseline (C-c G 1), edit, compare (C-c G 2).
;;
;;; Tools
;;
;; Install or upgrade all of them with `go-std-install-tools' (C-c G i) /
;; `go-std-upgrade-tools' (C-c G u).  They are installed into a private bin
;; directory (see `go-std-tools-directory') so they never collide with, or
;; overwrite, the tools in your normal GOBIN.
;;
;;   toolstash  golang.org/x/tools/cmd/toolstash
;;       Saves a known-good copy of the toolchain, then re-runs a build with
;;       both the saved and the current compiler and compares the object code.
;;       This is how you prove a refactoring of the compiler changed no
;;       generated code -- the single most valuable safety net when
;;       restructuring cmd/compile.  Usage:
;;           toolstash save                       # snapshot the good toolchain
;;           # ... edit the compiler, go install cmd/compile ...
;;           go build -toolexec 'toolstash -cmp' -a std
;;       Any difference is reported per function.
;;
;;   benchstat  golang.org/x/perf/cmd/benchstat
;;       Compares `go test -bench' output across runs, with statistics.  A
;;       single benchmark run is noise; benchstat tells you whether a
;;       difference is real.  Always collect several iterations (-count=10 is
;;       a reasonable default) on an otherwise idle machine.
;;
;;   stringer  golang.org/x/tools/cmd/stringer
;;       Generates String() methods for typed constants.  Used throughout the
;;       Go tree (compiler opcodes, SSA ops, runtime state enums); when you
;;       add a constant to such a block you must regenerate.
;;
;;   compilebench  golang.org/x/tools/cmd/compilebench
;;       Benchmarks the *compiler itself* -- how fast it compiles packages.
;;       Use it when your compiler change might affect compile time.
;;
;;   stress  golang.org/x/tools/cmd/stress
;;       Runs a test repeatedly in parallel until it fails.  The standard way
;;       to reproduce a flaky runtime or scheduler test.
;;
;;   perflock  github.com/aclements/perflock  (Linux only, optional)
;;       Serialises benchmark runs and pins CPU frequency so results are
;;       comparable.  On macOS there is no equivalent; close everything else
;;       and disable low-power mode instead.
;;
;;; Diagnostics
;;
;;   `go-std-escape-analysis' (C-c G m) runs the compiler with -gcflags=-m and
;;   shows the escape-analysis and inlining decisions, optionally as inline
;;   overlays next to the responsible lines.
;;
;;   Note: -m reports the decisions the optimiser actually made.  Combining it
;;   with -N -l (disable optimisation and inlining) is self-defeating -- you
;;   then get "cannot inline" for everything because you just turned inlining
;;   off.  Use `go-std-escape-analysis' for decisions, and
;;   `go-std-build-unoptimised' (C-c G n) only when you want a build suitable
;;   for stepping in a debugger.
;;
;;   `go-std-ssa-at-point' (C-c G s) sets GOSSAFUNC for the function at point
;;   and opens the compiler's SSA dump in a browser, letting you watch the IR
;;   through every optimisation pass.  Output is written to a temporary
;;   directory rather than into your checkout.
;;
;;; Worked example: making bytes.Index faster
;;
;;   1. Open $GOROOT/src/bytes/bytes.go.  The mode line shows go/std, and
;;      `go-std-describe-environment' (C-c G e) confirms which `go' will run.
;;
;;   2. Take a baseline, before changing anything:
;;        C-c G 1   bench regexp: BenchmarkIndex   count: 10
;;      This runs, in the package directory, with the tree's own toolchain:
;;        go test -run='^$' -bench=BenchmarkIndex -count=10 .
;;      -run='^$' matches no tests, so only benchmarks execute.  The output is
;;      saved as this package's baseline.
;;
;;   3. Edit bytes.go.
;;
;;   4. Compare:
;;        C-c G 2   (same regexp and count)
;;      The new run is captured and benchstat compares it against the
;;      baseline, in *go-std benchstat*:
;;
;;        goos: darwin
;;        goarch: arm64
;;        pkg: bytes
;;                    │  baseline   │             current              │
;;                    │   sec/op    │   sec/op     vs base             │
;;        Index/32-10   24.15n ± 2%   19.02n ± 1%  -21.24% (p=0.000 n=10)
;;
;;      Read it as: ± is the range across iterations, p is the probability the
;;      difference is chance.  p < 0.05 with n=10 is a real result; "~" in the
;;      vs base column means benchstat found no significant difference,
;;      regardless of how different the means look.
;;
;;   5. Confirm correctness: C-c G t runs `go test .' for bytes.
;;
;;   6. If the change touched the compiler rather than the library, prove the
;;      generated code is identical where it should be: C-c G k then C-c G K.
;;
;;; Caveats
;;
;; GOSSAFUNC, GOSSADIR, the exact format of -gcflags=-m output, and toolstash
;; flags are compiler-internal and change between Go releases.  Commands that
;; depend on them prompt with a sensible default rather than assuming exact
;; semantics, and are marked in the code.

;;; Code:

(require 'compile)
(require 'subr-x)
(require 'seq)

;;;; Customization

(defgroup go-std nil
  "Develop the Go toolchain, runtime and standard library."
  :group 'tools
  :prefix "go-std-")

(defcustom go-std-goroot-bootstrap nil
  "GOROOT of a released Go used to build the development tree.
Passed to src/make.bash as GOROOT_BOOTSTRAP.  When nil, make.bash
locates a bootstrap toolchain itself (it searches ~/go1.4,
~/sdk/goN.M and similar), which is usually what you want."
  :type '(choice (const :tag "Let make.bash decide" nil) directory)
  :group 'go-std)

(defcustom go-std-gobin (locate-user-emacs-file "go-std-tools/bin")
  "Directory used as GOBIN inside a recognised Go repository.
Isolating GOBIN keeps `go install' in a development tree from
overwriting the binaries in your everyday GOBIN.  Set to nil to
inherit the ambient GOBIN."
  :type '(choice (const :tag "Inherit" nil) directory)
  :group 'go-std)

(defcustom go-std-gopath nil
  "GOPATH to use inside a recognised Go repository, or nil to inherit.
Defaults to nil deliberately.  GOPATH holds the module cache, which
is large and shared; overriding it per project forces every
dependency to be downloaded again into the new location and buys
almost nothing, because GOBIN (above) is what actually causes
cross-project contamination.  Override only if you need a genuinely
hermetic module cache."
  :type '(choice (const :tag "Inherit" nil) directory)
  :group 'go-std)

(defcustom go-std-set-goroot t
  "Whether to export GOROOT for commands run inside the Go tree.
A go binary determines its own GOROOT from its location, so this is
usually redundant; it is exported anyway because subprocesses and
helper tools sometimes consult it.  It is always omitted for
make.bash and all.bash, which manage GOROOT themselves."
  :type 'boolean
  :group 'go-std)

(defcustom go-std-tools-directory (locate-user-emacs-file "go-std-tools/bin")
  "Directory the Go development helper tools are installed into.
Derived from `user-emacs-directory' rather than hardcoded.  Placed
on `exec-path' and PATH inside a recognised repository."
  :type 'directory
  :group 'go-std)

(defcustom go-std-tools
  '((benchstat    "golang.org/x/perf/cmd/benchstat"      t
                  "Statistical comparison of go test -bench output.")
    (toolstash    "golang.org/x/tools/cmd/toolstash"     t
                  "Snapshot a toolchain and compare generated object code.")
    (stringer     "golang.org/x/tools/cmd/stringer"      t
                  "Generate String() methods for typed constants.")
    (compilebench "golang.org/x/tools/cmd/compilebench"  nil
                  "Benchmark the compiler itself.")
    (stress       "golang.org/x/tools/cmd/stress"        nil
                  "Run a test repeatedly to reproduce flakes."))
  "Helper tools managed by `go-std-install-tools'.
Each entry is (NAME IMPORT-PATH REQUIRED DESCRIPTION).  REQUIRED
entries are reported as missing by `go-std-describe-environment'."
  :type '(repeat (list (symbol :tag "Name")
                       (string :tag "Import path")
                       (boolean :tag "Required")
                       (string :tag "Description")))
  :group 'go-std)

(defcustom go-std-bench-count 10
  "Default -count for benchmark runs.
One iteration is noise.  benchstat needs several to say anything."
  :type 'integer
  :group 'go-std)

(defcustom go-std-bench-flags '("-run=^$")
  "Extra flags for benchmark runs.
The default matches no tests, so only benchmarks execute."
  :type '(repeat string)
  :group 'go-std)

(defcustom go-std-escape-flags "-gcflags=-m"
  "Flags used by `go-std-escape-analysis'.
Use -gcflags=-m=2 for more detail, or -gcflags=all=-m to include
dependencies.  Deliberately does not include -N -l: those disable
the optimisations whose decisions -m reports."
  :type 'string
  :group 'go-std)

(defcustom go-std-unoptimised-flags "-gcflags=all=-N -l"
  "Flags used by `go-std-build-unoptimised' for debugger-friendly builds."
  :type 'string
  :group 'go-std)

(defcustom go-std-toolstash-target "std"
  "Build target compared by `go-std-toolstash-compare'."
  :type 'string
  :group 'go-std)

(defcustom go-std-annotate-inline t
  "Whether `go-std-escape-analysis' also places inline overlays."
  :type 'boolean
  :group 'go-std)

(defcustom go-std-x-repo-regexp "\\`\\(golang\\.org/x/\\|github\\.com/golang/\\)"
  "Regexp matching module paths treated as Go project repositories."
  :type 'regexp
  :group 'go-std)

(defcustom go-std-keymap-prefix "C-c G"
  "Prefix key for `go-std-mode-map'.
Avoids C-g in every chord: that key is commonly consumed by a
terminal multiplexer and never reaches Emacs.  Changing this after
the mode is loaded requires re-evaluating the file."
  :type 'string
  :group 'go-std)

(defface go-std-annotation-face
  '((t :inherit shadow :height 0.9))
  "Face for inline compiler annotations."
  :group 'go-std)

;;;; Repository detection
;;
;; Results are memoised per directory: the globalized mode consults this for
;; every buffer that changes major mode, and each miss costs a directory walk.

(defvar go-std--context-cache (make-hash-table :test #'equal)
  "Cache mapping a directory to its context, as returned by `go-std-context'.")

(defun go-std--goroot-p (dir)
  "Return non-nil when DIR is the root of a Go source tree."
  (and (file-exists-p (expand-file-name "src/make.bash" dir))
       (file-directory-p (expand-file-name "src/cmd/compile" dir))))

(defun go-std--find-goroot (dir)
  "Return the Go source tree containing DIR, or nil."
  (let ((root (locate-dominating-file dir #'go-std--goroot-p)))
    (and root (file-name-as-directory (expand-file-name root)))))

(defun go-std--module-path (modfile)
  "Return the module path declared in MODFILE, or nil."
  (when (file-readable-p modfile)
    (with-temp-buffer
      (insert-file-contents modfile nil 0 4096)
      (goto-char (point-min))
      (when (re-search-forward "^module[ \t]+\\([^ \t\n]+\\)" nil t)
        (match-string 1)))))

(defun go-std--find-module (dir)
  "Return (ROOT . MODULE-PATH) for the module containing DIR, or nil."
  (let ((root (locate-dominating-file dir "go.mod")))
    (when root
      (setq root (file-name-as-directory (expand-file-name root)))
      (cons root (go-std--module-path (expand-file-name "go.mod" root))))))

(defun go-std--compute-context (dir)
  "Compute the Go development context for DIR.
Returns a plist (:kind KIND :root ROOT :module PATH) or nil.
KIND is `goroot' or `x-repo'.  The Go tree is checked first: it
contains src/go.mod and src/cmd/go.mod, so searching upward for
go.mod would otherwise report src/ as the project root."
  (let ((goroot (go-std--find-goroot dir)))
    (if goroot
        (list :kind 'goroot :root goroot :module nil)
      (let ((mod (go-std--find-module dir)))
        (when (and mod (cdr mod)
                   (string-match-p go-std-x-repo-regexp (cdr mod)))
          (list :kind 'x-repo :root (car mod) :module (cdr mod)))))))

(defun go-std-context (&optional dir)
  "Return the Go development context for DIR, memoised.
DIR defaults to `default-directory'.  See `go-std--compute-context'."
  (let* ((dir (file-name-as-directory
               (expand-file-name (or dir default-directory))))
         (hit (gethash dir go-std--context-cache 'miss)))
    (if (eq hit 'miss)
        (puthash dir (go-std--compute-context dir) go-std--context-cache)
      hit)))

;;;###autoload
(defun go-std-flush-cache ()
  "Forget cached repository detection results.
Call this after creating, moving or deleting a Go checkout."
  (interactive)
  (clrhash go-std--context-cache)
  (message "go-std: detection cache cleared"))

(defun go-std--root ()
  "Return the repository root for the current buffer, or nil."
  (plist-get (go-std-context) :root))

(defun go-std--kind ()
  "Return the context kind for the current buffer, or nil."
  (plist-get (go-std-context) :kind))

(defun go-std--goroot ()
  "Return the GOROOT for the current buffer, or nil when not in the Go tree."
  (let ((ctx (go-std-context)))
    (and (eq (plist-get ctx :kind) 'goroot) (plist-get ctx :root))))

(defun go-std--require-goroot ()
  "Return the GOROOT for the current buffer, or signal an error."
  (or (go-std--goroot)
      (user-error "Not inside a Go source tree (no src/make.bash above %s)"
                  (abbreviate-file-name default-directory))))

(defun go-std--require-context ()
  "Return the context for the current buffer, or signal an error."
  (or (go-std-context)
      (user-error "Not inside a Go tree or a golang.org/x module")))

;;;; Environment

(defun go-std--path-entries ()
  "Return directories to prepend to PATH and `exec-path'."
  (let ((goroot (go-std--goroot))
        (dirs nil))
    (when (and go-std-tools-directory
               (file-directory-p go-std-tools-directory))
      (push (expand-file-name go-std-tools-directory) dirs))
    (when goroot
      (push (expand-file-name "bin" goroot) dirs))
    (nreverse dirs)))

(defun go-std-exec-path ()
  "Return `exec-path' with the development toolchain first."
  (append (go-std--path-entries) exec-path))

(defun go-std-process-environment (&optional omit-goroot)
  "Return `process-environment' configured for the current context.
When OMIT-GOROOT is non-nil, GOROOT is not exported -- required for
make.bash and all.bash, which derive and validate it themselves."
  (let ((process-environment (copy-sequence process-environment))
        (goroot (go-std--goroot))
        (dirs (go-std--path-entries)))
    (when dirs
      (setenv "PATH" (concat (mapconcat #'identity dirs path-separator)
                             path-separator (getenv "PATH"))))
    (when (and goroot go-std-set-goroot (not omit-goroot))
      (setenv "GOROOT" (directory-file-name goroot)))
    (when go-std-goroot-bootstrap
      (setenv "GOROOT_BOOTSTRAP"
              (directory-file-name (expand-file-name go-std-goroot-bootstrap))))
    (when go-std-gobin
      (setenv "GOBIN" (directory-file-name (expand-file-name go-std-gobin))))
    (when go-std-gopath
      (setenv "GOPATH" (directory-file-name (expand-file-name go-std-gopath))))
    process-environment))

(defmacro go-std-with-environment (&rest body)
  "Run BODY with the development toolchain first on PATH and `exec-path'."
  (declare (indent 0) (debug t))
  `(let ((process-environment (go-std-process-environment))
         (exec-path (go-std-exec-path)))
     ,@body))

(defun go-std--go-program ()
  "Return the `go' binary that commands in this buffer will use."
  (go-std-with-environment (executable-find "go")))

(defun go-std--stable-go ()
  "Return a released `go' binary, never the development toolchain.
Helper tools are built with this: you install them in order to
diagnose a development compiler, so building them with that same
compiler would be circular."
  (or (and go-std-goroot-bootstrap
           (let ((exe (expand-file-name "bin/go" go-std-goroot-bootstrap)))
             (and (file-executable-p exe) exe)))
      (let ((exec-path (default-value 'exec-path)))
        (executable-find "go"))
      (user-error "No released go found; set `go-std-goroot-bootstrap'")))

;;;; Running commands

(defun go-std--compile (name command &optional dir omit-goroot)
  "Run COMMAND in DIR through `compilation-mode', in a buffer named for NAME.
OMIT-GOROOT is passed to `go-std-process-environment'."
  (let* ((default-directory (or dir default-directory))
         (process-environment (go-std-process-environment omit-goroot))
         (exec-path (go-std-exec-path))
         (compilation-buffer-name-function
          (lambda (&rest _) (format "*go-std %s*" name))))
    (compilation-start command)))

(defun go-std--shell-quote (args)
  "Join ARGS into a shell command, quoting each element."
  (mapconcat #'shell-quote-argument args " "))

(defun go-std--package-directory ()
  "Return the directory of the package containing the current buffer."
  (if buffer-file-name
      (file-name-directory buffer-file-name)
    default-directory))

;;;; Building the toolchain

;;;###autoload
(defun go-std-build-toolchain ()
  "Build the Go toolchain with src/make.bash, without running tests.
This is the full build.  During an edit/test cycle on the compiler
prefer `go-std-install-compiler', which is far faster."
  (interactive)
  (let ((goroot (go-std--require-goroot)))
    (go-std--compile "make.bash" "./make.bash"
                     (expand-file-name "src" goroot) t)))

;;;###autoload
(defun go-std-build-all ()
  "Build the toolchain and run the full test suite with src/all.bash.
Takes many minutes.  Use before mailing a change, not in a loop."
  (interactive)
  (let ((goroot (go-std--require-goroot)))
    (go-std--compile "all.bash" "./all.bash"
                     (expand-file-name "src" goroot) t)))

;;;###autoload
(defun go-std-install-compiler (&optional target)
  "Rebuild TARGET, by default cmd/compile, with the development toolchain.
This is the fast inner loop for compiler work: it rebuilds only the
compiler, leaving the rest of the toolchain alone.  With a prefix
argument, prompt for a different target such as cmd/link or cmd/go."
  (interactive
   (list (when current-prefix-arg
           (read-string "go install target: " "cmd/compile"))))
  (let ((goroot (go-std--require-goroot)))
    (go-std--compile "install"
                     (format "go install %s"
                             (shell-quote-argument (or target "cmd/compile")))
                     (expand-file-name "src" goroot))))

;;;; Testing

;;;###autoload
(defun go-std-test-package (&optional flags)
  "Run `go test' for the package in the current directory.
Uses the toolchain built from the tree, not the system go.  With a
prefix argument, prompt for extra flags."
  (interactive
   (list (when current-prefix-arg (read-string "Extra go test flags: "))))
  (go-std--require-context)
  (go-std--compile "test"
                   (string-trim (format "go test %s ." (or flags "")))
                   (go-std--package-directory)))

;;;###autoload
(defun go-std-test-run (pattern)
  "Run the tests matching PATTERN in the current package."
  (interactive (list (read-string "go test -run: " "Test")))
  (go-std--require-context)
  (go-std--compile "test"
                   (format "go test -run %s -v ."
                           (shell-quote-argument pattern))
                   (go-std--package-directory)))

;;;###autoload
(defun go-std-test-runtime (&optional pattern)
  "Run the runtime package tests from the Go tree.
With a prefix argument, prompt for a -run PATTERN."
  (interactive
   (list (when current-prefix-arg (read-string "go test -run: " "Test"))))
  (let ((goroot (go-std--require-goroot)))
    (go-std--compile
     "runtime"
     (if pattern
         (format "go test -run %s runtime" (shell-quote-argument pattern))
       "go test runtime")
     (expand-file-name "src" goroot))))

;;;###autoload
(defun go-std-build-unoptimised ()
  "Build the current package with optimisation and inlining disabled.
Produces code that a debugger can step through sensibly.  This is
not the right way to inspect optimiser decisions -- see
`go-std-escape-analysis'."
  (interactive)
  (go-std--require-context)
  (go-std--compile "build"
                   (format "go build %s ."
                           (shell-quote-argument go-std-unoptimised-flags))
                   (go-std--package-directory)))

;;;; toolstash

;;;###autoload
(defun go-std-toolstash-save ()
  "Snapshot the current toolchain with `toolstash save'.
Do this while the tree is known good, before changing the compiler."
  (interactive)
  (let ((goroot (go-std--require-goroot)))
    (unless (go-std-with-environment (executable-find "toolstash"))
      (user-error "toolstash not found; run M-x go-std-install-tools"))
    (go-std--compile "toolstash" "toolstash save"
                     (expand-file-name "src" goroot))))

;;;###autoload
(defun go-std-toolstash-compare (&optional target)
  "Compare generated object code against the toolstash snapshot.
Rebuilds TARGET, by default `go-std-toolstash-target', running each
compilation under both the saved and the current compiler and
diffing the results.  A clean run proves the change altered no
generated code, which is the point of the exercise when refactoring
cmd/compile.  Requires `go-std-toolstash-save' first."
  (interactive
   (list (when current-prefix-arg
           (read-string "toolstash compare target: " go-std-toolstash-target))))
  (let ((goroot (go-std--require-goroot)))
    (unless (go-std-with-environment (executable-find "toolstash"))
      (user-error "toolstash not found; run M-x go-std-install-tools"))
    (go-std--compile
     "toolstash"
     (format "go build -toolexec %s -a %s"
             (shell-quote-argument "toolstash -cmp")
             (shell-quote-argument (or target go-std-toolstash-target)))
     (expand-file-name "src" goroot))))

;;;; Benchmarking

(defun go-std--bench-directory ()
  "Return the directory holding captured benchmark output, creating it."
  (let ((dir (locate-user-emacs-file "go-std-tools/bench")))
    (unless (file-directory-p dir)
      (make-directory dir t))
    dir))

(defun go-std--bench-file (kind)
  "Return the file holding the KIND benchmark capture for this package."
  (let* ((dir (directory-file-name (go-std--package-directory)))
         (tag (replace-regexp-in-string "[^A-Za-z0-9]+" "_" dir)))
    (expand-file-name (format "%s.%s.txt" tag kind) (go-std--bench-directory))))

(defun go-std--bench-command (pattern count file)
  "Return a shell command benchmarking PATTERN COUNT times into FILE."
  (format "go test %s -bench %s -count %d . 2>&1 | tee %s"
          (go-std--shell-quote go-std-bench-flags)
          (shell-quote-argument pattern)
          count
          (shell-quote-argument file)))

(defun go-std--compile-then (name command dir callback)
  "Run COMMAND in DIR as NAME, then call CALLBACK when it finishes.
CALLBACK receives the compilation exit status string."
  (let ((buffer (go-std--compile name command dir)))
    (with-current-buffer buffer
      (add-hook 'compilation-finish-functions
                (lambda (_buf status)
                  (funcall callback status))
                nil t))
    buffer))

;;;###autoload
(defun go-std-bench-baseline (pattern count)
  "Capture a benchmark baseline for the current package.
PATTERN is a -bench regexp and COUNT the number of iterations.
Several iterations are required for `benchstat' to distinguish a
real change from noise."
  (interactive
   (list (read-string "Baseline -bench regexp: " ".")
         (read-number "Iterations (-count): " go-std-bench-count)))
  (go-std--require-context)
  (let ((file (go-std--bench-file "baseline")))
    (go-std--compile-then
     "bench" (go-std--bench-command pattern count file)
     (go-std--package-directory)
     (lambda (_status)
       (message "go-std: baseline saved to %s" (abbreviate-file-name file))))))

;;;###autoload
(defun go-std-bench-compare (pattern count)
  "Re-run the benchmarks and compare against the saved baseline.
Runs PATTERN COUNT times, then renders a `benchstat' comparison of
the baseline against this run."
  (interactive
   (list (read-string "Compare -bench regexp: " ".")
         (read-number "Iterations (-count): " go-std-bench-count)))
  (go-std--require-context)
  (let ((baseline (go-std--bench-file "baseline"))
        (current (go-std--bench-file "current")))
    (unless (file-readable-p baseline)
      (user-error "No baseline for this package; run `go-std-bench-baseline'"))
    (go-std--compile-then
     "bench" (go-std--bench-command pattern count current)
     (go-std--package-directory)
     (lambda (_status) (go-std-benchstat baseline current)))))

;;;###autoload
(defun go-std--benchstat-args (old new labelled)
  "Return benchstat arguments comparing OLD and NEW.
When LABELLED is non-nil use the `name=file\' form, which makes
benchstat title the columns rather than printing full paths."
  (if labelled
      (list (concat "baseline=" (expand-file-name old))
            (concat "current=" (expand-file-name new)))
    (list (expand-file-name old) (expand-file-name new))))

;;;###autoload
(defun go-std-benchstat (old new)
  "Compare benchmark output files OLD and NEW with `benchstat\'.
Prefers benchstat\'s labelled inputs so the comparison table is
headed \"baseline\" and \"current\" instead of two long paths, and
falls back to plain file arguments for versions predating that
syntax."
  (interactive
   (list (read-file-name "Baseline results: " (go-std--bench-directory))
         (read-file-name "New results: " (go-std--bench-directory))))
  (let ((program (go-std-with-environment (executable-find "benchstat"))))
    (unless program
      (user-error "benchstat not found; run M-x go-std-install-tools"))
    (let ((buffer (get-buffer-create "*go-std benchstat*")))
      (with-current-buffer buffer
        (let ((inhibit-read-only t))
          (erase-buffer)
          (insert (format "$ benchstat %s %s\n\n"
                          (abbreviate-file-name old)
                          (abbreviate-file-name new)))
          (let ((start (point)))
            (unless (eq 0 (apply #'call-process program nil t nil
                                 (go-std--benchstat-args old new t)))
              (delete-region start (point-max))
              (apply #'call-process program nil t nil
                     (go-std--benchstat-args old new nil)))))
        (goto-char (point-min))
        (special-mode))
      (display-buffer buffer))))

;;;; SSA inspection
;;
;; GOSSAFUNC and GOSSADIR are compiler-internal and have changed shape across
;; releases, so the function name is offered as an editable default rather
;; than asserted, and the output file is located by searching the directory
;; instead of assuming a fixed name.

(defconst go-std--func-regexp
  "^func[ \t]+\\(?:(\\([^)]*\\))[ \t]*\\)?\\([A-Za-z_][A-Za-z0-9_]*\\)"
  "Regexp matching a Go function or method declaration.
Group 1 is the receiver, if any; group 2 is the name.")

(defun go-std--receiver-type (receiver)
  "Return the GOSSAFUNC spelling of RECEIVER, or nil."
  (when (and receiver (string-match
                       "\\(\\*?\\)[ \t]*\\([A-Za-z_][A-Za-z0-9_]*\\)[ \t]*\\'"
                       receiver))
    (let ((pointer (match-string 1 receiver))
          (type (match-string 2 receiver)))
      (if (string-empty-p pointer) type (format "(*%s)" type)))))

(defun go-std-function-at-point ()
  "Return the name of the function surrounding point, or nil.
Methods are spelled as the compiler names them, T.M or (*T).M."
  (save-excursion
    (end-of-line)
    (when (re-search-backward go-std--func-regexp nil t)
      ;; Read both groups before calling out: `go-std--receiver-type' runs
      ;; `string-match', which would clobber this match data.
      (let* ((raw (match-string 1))
             (name (match-string 2))
             (recv (go-std--receiver-type raw)))
        (if recv (format "%s.%s" recv name) name)))))

;;;###autoload
(defun go-std-ssa-at-point (function)
  "Dump the compiler's SSA for FUNCTION and open it in a browser.
Defaults to the function surrounding point.  The build runs with
GOSSADIR pointing at a temporary directory so the HTML is never
written into your checkout."
  (interactive
   (list (read-string "GOSSAFUNC: " (or (go-std-function-at-point) ""))))
  (go-std--require-context)
  (when (string-empty-p function)
    (user-error "No function given"))
  (let* ((dir (go-std--package-directory))
         (out (make-temp-file "go-std-ssa" t))
         (default-directory dir)
         (process-environment (go-std-process-environment))
         (exec-path (go-std-exec-path)))
    (setenv "GOSSAFUNC" function)
    (setenv "GOSSADIR" out)
    (with-temp-buffer
      (let ((status (process-file shell-file-name nil (list t t) nil
                                  shell-command-switch "go build -a .")))
        (let ((html (car (sort (directory-files out t "\\.html\\'")
                               #'file-newer-than-file-p))))
          (cond
           (html (browse-url-of-file html)
                 (message "go-std: SSA for %s -> %s" function html))
           ((file-exists-p (expand-file-name "ssa.html" dir))
            ;; Older compilers ignore GOSSADIR and write into the package.
            (browse-url-of-file (expand-file-name "ssa.html" dir))
            (message "go-std: SSA written into %s (GOSSADIR unsupported)" dir))
           (t (let ((log (get-buffer-create "*go-std ssa*")))
                (with-current-buffer log
                  (let ((inhibit-read-only t))
                    (erase-buffer)
                    (insert (buffer-string)))
                  (special-mode))
                (display-buffer log)
                (user-error
                 "No SSA output (exit %s); is %s a function in this package?"
                 status function)))))))))

;;;; Escape analysis and inlining

(defvar go-std--annotations nil
  "Overlays created by `go-std-escape-analysis'.")

(defun go-std-clear-annotations ()
  "Remove the inline annotations added by `go-std-escape-analysis'."
  (interactive)
  (mapc #'delete-overlay go-std--annotations)
  (setq go-std--annotations nil))

(defun go-std--annotate (dir text)
  "Create inline overlays for compiler diagnostics TEXT relative to DIR."
  (go-std-clear-annotations)
  (let ((count 0))
    (dolist (line (split-string text "\n" t))
      (when (string-match
             "\\`\\(.+?\\):\\([0-9]+\\):\\([0-9]+\\): \\(.*\\)\\'" line)
        (let* ((file (expand-file-name (match-string 1 line) dir))
               (row (string-to-number (match-string 2 line)))
               (msg (match-string 4 line))
               (buf (get-file-buffer file)))
          (when buf
            (with-current-buffer buf
              (save-excursion
                (goto-char (point-min))
                (forward-line (1- row))
                ;; Zero-length overlay carrying an after-string.  It must
                ;; NOT be given the `evaporate' property: an evaporating
                ;; overlay whose length is zero is deleted the moment the
                ;; property is set, which silently discards every annotation.
                (let ((ov (make-overlay (line-end-position)
                                        (line-end-position))))
                  (overlay-put ov 'after-string
                               (propertize (concat "  " msg)
                                           'face 'go-std-annotation-face))
                  (overlay-put ov 'go-std t)
                  (push ov go-std--annotations)
                  (setq count (1+ count)))))))))
    count))

;;;###autoload
(defun go-std-escape-analysis (&optional force)
  "Show escape-analysis and inlining decisions for the current package.
Runs the compiler with `go-std-escape-flags' and presents the
diagnostics in a compilation buffer, additionally annotating open
buffers inline when `go-std-annotate-inline' is non-nil.

Diagnostics are replayed from the build cache, so a repeated run
still reports them.  With a prefix argument FORCE, pass -a to
recompile dependencies as well."
  (interactive "P")
  (go-std--require-context)
  (let* ((dir (go-std--package-directory))
         (default-directory dir)
         (process-environment (go-std-process-environment))
         (exec-path (go-std-exec-path))
         (command (format "go build %s %s -o %s ."
                          (if force "-a" "")
                          go-std-escape-flags
                          (shell-quote-argument null-device)))
         (output (with-temp-buffer
                   (process-file shell-file-name nil (list t t) nil
                                 shell-command-switch command)
                   (buffer-string)))
         (buffer (get-buffer-create "*go-std escape*")))
    (with-current-buffer buffer
      (let ((inhibit-read-only t))
        (erase-buffer)
        (insert (format "$ %s\n\n" command))
        (insert output))
      (goto-char (point-min))
      (compilation-mode))
    (display-buffer buffer)
    (if (not go-std-annotate-inline)
        (message "go-std: escape analysis complete")
      (let ((n (go-std--annotate dir output)))
        (message "go-std: %d inline annotation%s (%s to clear)"
                 n (if (= n 1) "" "s")
                 (substitute-command-keys
                  "\\[go-std-clear-annotations]"))))))

;;;; stringer

;;;###autoload
(defun go-std-stringer (type)
  "Run `stringer' for TYPE in the current package.
Regenerates the String method for a typed-constant block.  The Go
tree uses stringer widely -- SSA opcodes, runtime state enums --
and adding a constant without regenerating leaves the String method
silently wrong."
  (interactive (list (read-string "stringer -type: ")))
  (go-std--require-context)
  (unless (go-std-with-environment (executable-find "stringer"))
    (user-error "stringer not found; run M-x go-std-install-tools"))
  (when (string-empty-p type)
    (user-error "No type given"))
  (go-std--compile "stringer"
                   (format "stringer -type %s" (shell-quote-argument type))
                   (go-std--package-directory)))

;;;; Tool management

(defun go-std--tool-command (entry)
  "Return the `go install' command for tool ENTRY."
  (format "go install %s@latest" (shell-quote-argument (nth 1 entry))))

(defun go-std--install-tools (entries what)
  "Install ENTRIES into `go-std-tools-directory', describing the run as WHAT."
  (let ((go (go-std--stable-go))
        (dir (expand-file-name go-std-tools-directory)))
    (unless (file-directory-p dir)
      (make-directory dir t))
    (let* ((process-environment (copy-sequence process-environment))
           (default-directory temporary-file-directory)
           (compilation-buffer-name-function
            (lambda (&rest _) "*go-std tools*")))
      ;; Built with a released toolchain, and with GOBIN pointed at the
      ;; private directory so nothing in the user's GOBIN is overwritten.
      (setenv "GOBIN" (directory-file-name dir))
      (setenv "GOFLAGS" nil)
      (compilation-start
       (mapconcat (lambda (entry)
                    (concat (shell-quote-argument go)
                            (substring (go-std--tool-command entry) 2)))
                  entries " && ")
       nil)
      (message "go-std: %s %d tools into %s" what (length entries)
               (abbreviate-file-name dir)))))

;;;###autoload
(defun go-std-install-tools (&optional all)
  "Install the required Go development helper tools.
With a prefix argument ALL, install the optional tools as well.
Tools are built with a released Go and installed into
`go-std-tools-directory', which is placed ahead of PATH inside a
recognised repository."
  (interactive "P")
  (go-std--install-tools
   (if all go-std-tools (seq-filter (lambda (e) (nth 2 e)) go-std-tools))
   "installing"))

;;;###autoload
(defun go-std-upgrade-tools ()
  "Re-install every tool in `go-std-tools' at its latest version."
  (interactive)
  (go-std--install-tools go-std-tools "upgrading"))

;;;; Introspection

;;;###autoload
(defun go-std-describe-environment ()
  "Show the toolchain and environment commands in this buffer will use.
The first thing to check when something runs the wrong `go\'."
  (interactive)
  ;; Everything buffer-dependent is resolved *before* switching to the output
  ;; buffer.  Reading it afterwards would report on the output buffer, whose
  ;; `default-directory\' may be left over from an earlier project.
  (let* ((ctx (go-std-context))
         (origin (or buffer-file-name default-directory))
         (go (go-std--go-program))
         (version (and go (string-trim
                           (with-output-to-string
                             (with-current-buffer standard-output
                               (ignore-errors
                                 (call-process go nil t nil "version")))))))
         (goroot (go-std--goroot))
         (prefix (go-std--path-entries))
         (tools (mapcar (lambda (entry)
                          (list (symbol-name (car entry))
                                (go-std-with-environment
                                  (executable-find (symbol-name (car entry))))
                                (nth 2 entry)))
                        go-std-tools))
         (buffer (get-buffer-create "*go-std environment*")))
    (with-current-buffer buffer
      (let ((inhibit-read-only t))
        (erase-buffer)
        (insert "go-std environment\n==================\n\n")
        (insert (format "buffer      %s\n" origin))
        (if (not ctx)
            (insert "\ncontext     none -- not in a Go tree or golang.org/x module\n")
          (insert (format "context     %s\n" (plist-get ctx :kind)))
          (insert (format "root        %s\n" (plist-get ctx :root)))
          (when (plist-get ctx :module)
            (insert (format "module      %s\n" (plist-get ctx :module)))))
        (insert (format "\ngo          %s\n" (or go "not found")))
        (when version (insert (format "go version  %s\n" version)))
        (insert (format "GOROOT      %s\n"
                        (if (and goroot go-std-set-goroot)
                            (directory-file-name goroot)
                          "(not exported)")))
        (insert (format "GOBIN       %s\n"
                        (if go-std-gobin
                            (directory-file-name (expand-file-name go-std-gobin))
                          "(inherited)")))
        (insert (format "GOPATH      %s\n"
                        (if go-std-gopath
                            (directory-file-name (expand-file-name go-std-gopath))
                          "(inherited)")))
        (insert (format "bootstrap   %s\n"
                        (or go-std-goroot-bootstrap "(make.bash decides)")))
        (insert (format "\nPATH prefix %s\n"
                        (if prefix
                            (mapconcat #'identity prefix path-separator)
                          "(none)")))
        (insert "\ntools\n")
        (dolist (tool tools)
          (insert (format "  %-14s %s%s\n" (nth 0 tool)
                          (or (nth 1 tool) "MISSING")
                          (if (and (not (nth 1 tool)) (nth 2 tool))
                              "  (required)" ""))))
        (insert "\nInstall missing tools with M-x go-std-install-tools.\n"))
      (goto-char (point-min))
      (special-mode))
    (display-buffer buffer)))

;;;; Keymap
;;
;; Bound under a single prefix, `go-std-keymap-prefix' (default C-c G).  No
;; chord anywhere in this map uses C-g: terminal multiplexers commonly consume
;; it, so it would never reach Emacs.  The prefix also stays clear of the
;; per-language LSP bindings in lang-go.el (C-c r/j/d/,/i/t/s and friends),
;; which remain available inside Go buffers.

(defvar go-std-command-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "b") #'go-std-build-toolchain)
    (define-key map (kbd "B") #'go-std-build-all)
    (define-key map (kbd "c") #'go-std-install-compiler)
    (define-key map (kbd "t") #'go-std-test-package)
    (define-key map (kbd "T") #'go-std-test-run)
    (define-key map (kbd "r") #'go-std-test-runtime)
    (define-key map (kbd "n") #'go-std-build-unoptimised)
    (define-key map (kbd "m") #'go-std-escape-analysis)
    (define-key map (kbd "M") #'go-std-clear-annotations)
    (define-key map (kbd "s") #'go-std-ssa-at-point)
    (define-key map (kbd "k") #'go-std-toolstash-save)
    (define-key map (kbd "K") #'go-std-toolstash-compare)
    (define-key map (kbd "1") #'go-std-bench-baseline)
    (define-key map (kbd "2") #'go-std-bench-compare)
    (define-key map (kbd "d") #'go-std-benchstat)
    (define-key map (kbd "y") #'go-std-stringer)
    (define-key map (kbd "i") #'go-std-install-tools)
    (define-key map (kbd "u") #'go-std-upgrade-tools)
    (define-key map (kbd "e") #'go-std-describe-environment)
    (define-key map (kbd "F") #'go-std-flush-cache)
    map)
  "Keymap of `go-std-mode' commands, bound under `go-std-keymap-prefix'.")

(defvar go-std-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd go-std-keymap-prefix) go-std-command-map)
    map)
  "Keymap for `go-std-mode'.")

;;;; Minor modes

;;;###autoload
(define-minor-mode go-std-mode
  "Use the Go tree's own toolchain for commands run from this buffer.

Prepends the development toolchain to the buffer-local `exec-path'
and PATH, so compilation, tests, LSP and linters all resolve `go'
to the binary built from the repository rather than the system
installation.

\\{go-std-mode-map}"
  :lighter " go/std"
  :keymap go-std-mode-map
  :group 'go-std
  (if go-std-mode
      (let ((ctx (go-std-context)))
        (if (not ctx)
            (progn (setq go-std-mode nil)
                   (message "go-std: not inside a Go tree or golang.org/x module"))
          (setq-local exec-path (go-std-exec-path))
          (setq-local process-environment (go-std-process-environment))))
    (kill-local-variable 'exec-path)
    (kill-local-variable 'process-environment)))

(defun go-std--maybe-enable ()
  "Enable `go-std-mode' when this buffer belongs to a Go repository."
  (when (and buffer-file-name
             (not (bound-and-true-p go-std-mode))
             (go-std-context))
    (go-std-mode 1)))

;;;###autoload
(define-globalized-minor-mode go-std-global-mode go-std-mode
  go-std--maybe-enable
  :group 'go-std)

(provide 'go-std-mode)

;;; go-std-mode.el ends here
