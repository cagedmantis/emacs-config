# My Emacs Configuration

This is my Emacs configuration. It's an ever changing collection of configurations. Feel free to use it
or provide feedback.

## Minimum supported Emacs version

**Emacs 28.2.** The configuration must load and work on this version. Features that
require a newer Emacs are gated behind a version/feature check so they are simply
skipped on 28.2 rather than breaking startup.

## Coding agents in Emacs

Terminal-based coding agents (Anthropic **Claude Code** and others) run inside Emacs
via `lisp/init-agent.el`, in an [`eat`](https://codeberg.org/akib/emacs-eat) terminal
rooted at the current project.

- `M-x agent-start` — pick an agent and open it in the project root.
- `M-x agent-start-claude` — shortcut for Claude Code.

The selected CLI must be installed and on your `PATH`. Agents are configured in the
`agent-cli-commands` variable (defaults: `claude`, `aider`, `codex`, `gemini`); add
your own with any command line, e.g. `("aider" . "aider --model sonnet")`. To bind a
key, e.g. `(global-set-key (kbd "C-c v") #'agent-start)`.

## Key bindings

Bindings are defined across the `init-*`/`lang-*` files; this is the consolidated
reference. Having them in one place makes the whole keymap visible at a glance and
surfaces conflicts (e.g. a major-mode map shadowing a global prefix). Note that
per-mode bindings (Go, C/C++) shadow any global binding on the same key inside those
buffers.

### Global / windows

| Key | Command | Description |
|-----|---------|-------------|
| `C-x 1` | `init-toggle-delete-other-windows` | Maximize the current window, or restore the previous layout if already alone (reversible). |
| `C-c w` | `swap-meta-and-super` | macOS only: swap the Command/Option modifier mapping. |

### Project (project.el)

| Key | Command | Description |
|-----|---------|-------------|
| `C-c p` / `s-p` | `project-prefix-map` | Prefix for project commands: `f` find file, `p` switch project, `g` grep, `b` switch buffer, `c` compile, etc. |

### Completion & search (Vertico / Consult)

| Key | Command | Description |
|-----|---------|-------------|
| `C-x b` | `consult-buffer` | Switch buffer with live preview (buffers, recent files, bookmarks). |
| `M-y` | `consult-yank-pop` | Browse and insert from the kill ring. |
| `M-g g` | `consult-goto-line` | Jump to a line number with preview. |
| `M-g i` | `consult-imenu` | Jump to a symbol/definition in the buffer. |
| `M-g f` | `consult-flymake` | Jump between diagnostics. |
| `M-s l` | `consult-line` | Search lines in the current buffer (swiper-like). |
| `M-s r` | `consult-ripgrep` | Project-wide ripgrep search with preview. |
| `M-s d` | `consult-find` | Find files by name. |
| `M-A` | `marginalia-cycle` | (in minibuffer) cycle annotation detail. |

### Spelling

| Key | Command | Description |
|-----|---------|-------------|
| `C-q` | `flyspell-correct-wrapper` | Correct the misspelled word at point (in `flyspell-mode`). |

### Treemacs

| Key | Command | Description |
|-----|---------|-------------|
| `M-0` | `treemacs-select-window` | Jump to the Treemacs side window. |
| `C-x t t` | `treemacs` | Toggle the Treemacs file tree. |
| `C-x t d` | `treemacs-select-directory` | Open a directory in Treemacs. |

### Go (`go-mode`)

| Key | Command | Description |
|-----|---------|-------------|
| `C-c C-n` | `go-run` | Run the current package. |
| `C-c .` | `go-test-current-test` | Run the test at point. |
| `C-c f` | `go-test-current-file` | Run tests in the current file. |
| `C-c a` | `go-test-current-project` | Run all tests in the project. |
| `C-c r` | `lsp-rename` | Rename the symbol at point (gopls). |
| `C-c j` | `lsp-find-definition` | Jump to definition. |
| `C-c d` | `lsp-describe-thing-at-point` | Show docs for the symbol at point. |
| `C-c ,` | `lsp-find-references` | List references. |
| `C-c i` | `lsp-find-implementation` | Find implementations. |
| `C-c t` | `lsp-find-type-definition` | Jump to the type definition. |
| `C-c s` | `lsp-execute-code-action` | gopls code actions (e.g. Fill struct). |
| `C-c T` | `go-add-tags` | Add struct field tags. |

### Developing Go itself (`go-std-mode`, prefix `C-c G`)

Active only in buffers inside a golang/go checkout or a `golang.org/x/*`
module, where it makes commands use **that tree's** toolchain (`$GOROOT/bin/go`)
instead of the system `go`. The mode line shows `go/std`. The prefix avoids
`C-g`, which terminal multiplexers commonly intercept.

| Key | Command | Description |
|-----|---------|-------------|
| `C-c G e` | `go-std-describe-environment` | Show which `go`, GOROOT, GOBIN and tools this buffer will use. Start here when something looks wrong. |
| `C-c G b` | `go-std-build-toolchain` | Build the toolchain (`src/make.bash`), no tests. |
| `C-c G B` | `go-std-build-all` | Build and run the full test suite (`src/all.bash`). Minutes. |
| `C-c G c` | `go-std-install-compiler` | `go install cmd/compile` — the fast compiler edit loop. `C-u` for another target. |
| `C-c G t` | `go-std-test-package` | `go test .` for the current package. |
| `C-c G T` | `go-std-test-run` | `go test -run PATTERN -v .` |
| `C-c G r` | `go-std-test-runtime` | Run the runtime package tests. |
| `C-c G n` | `go-std-build-unoptimised` | Build with `-N -l` for debugger stepping. |
| `C-c G m` | `go-std-escape-analysis` | Escape-analysis and inlining decisions (`-gcflags=-m`), with inline annotations. |
| `C-c G M` | `go-std-clear-annotations` | Remove those annotations. |
| `C-c G s` | `go-std-ssa-at-point` | Dump compiler SSA for the function at point (`GOSSAFUNC`) and open it. |
| `C-c G k` | `go-std-toolstash-save` | Snapshot a known-good toolchain. |
| `C-c G K` | `go-std-toolstash-compare` | Prove a compiler change generates identical object code. |
| `C-c G 1` | `go-std-bench-baseline` | Capture a benchmark baseline for this package. |
| `C-c G 2` | `go-std-bench-compare` | Re-run and compare against the baseline via benchstat. |
| `C-c G d` | `go-std-benchstat` | Compare two saved benchmark files. |
| `C-c G y` | `go-std-stringer` | Regenerate a `String()` method with stringer. |
| `C-c G i` | `go-std-install-tools` | Install the helper tools (`C-u` includes optional ones). |
| `C-c G u` | `go-std-upgrade-tools` | Re-install every tool at latest. |
| `C-c G F` | `go-std-flush-cache` | Forget cached repository detection. |

### C / C++ (`cc-mode`, clangd)

| Key | Command | Description |
|-----|---------|-------------|
| `C-c r` | `lsp-rename` | Rename the symbol at point (clangd). |
| `C-c j` | `lsp-find-definition` | Jump to definition. |
| `C-c d` | `lsp-describe-thing-at-point` | Show docs for the symbol at point. |
| `C-c ,` | `lsp-find-references` | List references. |
| `C-c i` | `lsp-find-implementation` | Find implementations. |
| `C-c t` | `lsp-find-type-definition` | Jump to the type definition. |
| `C-c s` | `lsp-execute-code-action` | clangd code actions / quick-fixes. |
| `C-c o` | `lsp-clangd-find-other-file` | Switch between header and implementation. |

### Python (`python-mode`)

Same LSP bindings as Go/C++ (server auto-detected; format-on-save via ruff).

| Key | Command | Description |
|-----|---------|-------------|
| `C-c r` | `lsp-rename` | Rename the symbol at point. |
| `C-c j` | `lsp-find-definition` | Jump to definition. |
| `C-c d` | `lsp-describe-thing-at-point` | Show docs for the symbol at point. |
| `C-c ,` | `lsp-find-references` | List references. |
| `C-c i` | `lsp-find-implementation` | Find implementations. |
| `C-c t` | `lsp-find-type-definition` | Jump to the type definition. |
| `C-c s` | `lsp-execute-code-action` | Code actions / quick-fixes. |

### Assembly / WebAssembly

No custom key bindings — Assembly (`asm-mode`/`nasm-mode`, via `asm-lsp`) and
WebAssembly (`wat-ts-mode`, or the `wat-mode` fallback when the tree-sitter
grammar is not installed; both via `wat_server`) use the standard `lsp-mode`
bindings under the `s-l` prefix when a language server is installed.

## Installing external tools

Most language features (LSP, linting, formatting, debugging) stay silently off
until their external tool is installed. Each tool lists **macOS** (Homebrew) and
**Linux** commands; Linux uses Debian/Ubuntu `apt` as the example (dnf/pacman are
analogous). After installing, **restart Emacs (or the daemon)** so
`exec-path-from-shell` picks up the new `PATH`. Make sure the relevant bin dirs
are on `PATH`: `~/.local/bin` (uv/pipx), `~/.cargo/bin` (cargo), your npm global
prefix, and (macOS) `/opt/homebrew/opt/llvm/bin` (LLVM).

### Prerequisites (cross-platform installers used below)

Once these runtimes are present, the `uv`/`cargo`/`npm -g` commands further down
run identically on macOS and Linux.

```sh
# uv (Python tooling)
#   macOS:  brew install uv
#   Linux:  curl -LsSf https://astral.sh/uv/install.sh | sh
# Node + npm
#   macOS:  brew install node
#   Linux:  sudo apt install nodejs npm
# Rust + cargo
#   macOS:  brew install rust
#   Linux:  sudo apt install cargo      # or rustup: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### General (search, spelling)

```sh
# ripgrep — consult-ripgrep (M-s r)
#   macOS:  brew install ripgrep
#   Linux:  sudo apt install ripgrep
# aspell — flyspell (optional: without a spell checker flyspell simply
#   stays off, rather than erroring on every buffer)
#   macOS:  brew install aspell
#   Linux:  sudo apt install aspell aspell-en
```

### Go

```sh
# Go toolchain
#   macOS:  brew install go
#   Linux:  sudo apt install golang-go      # or the tarball from https://go.dev/dl
# golangci-lint (linter: errcheck/staticcheck/…)
#   macOS:  brew install golangci-lint
#   Linux:  curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/HEAD/install.sh | sh -s -- -b $(go env GOPATH)/bin
# gopls (LSP) + dlv (debugger) + the rest of `go-tools` (cross-platform):
#   in Emacs:  M-x go-install-tools
#   or:  go install golang.org/x/tools/gopls@latest
#        go install github.com/go-delve/delve/cmd/dlv@latest
```

### Go toolchain development (`go-std-mode`)

Only needed if you work on the Go tree itself. The helper tools are installed
**by Emacs** into an isolated directory (`~/.emacs.d/go-std-tools/bin`) so they
never overwrite the binaries in your normal `GOBIN`:

```
M-x go-std-install-tools        # required tools
C-u M-x go-std-install-tools    # also the optional ones
M-x go-std-upgrade-tools        # re-install all at @latest
```

The equivalent by hand, cross-platform (needs a released Go on PATH):

```sh
GOBIN=~/.emacs.d/go-std-tools/bin go install golang.org/x/perf/cmd/benchstat@latest
GOBIN=~/.emacs.d/go-std-tools/bin go install golang.org/x/tools/cmd/toolstash@latest
GOBIN=~/.emacs.d/go-std-tools/bin go install golang.org/x/tools/cmd/stringer@latest
# optional
GOBIN=~/.emacs.d/go-std-tools/bin go install golang.org/x/tools/cmd/compilebench@latest
GOBIN=~/.emacs.d/go-std-tools/bin go install golang.org/x/tools/cmd/stress@latest
```

Building the Go tree also needs a C toolchain and a bootstrap Go:

```sh
# C toolchain (cgo, assembly tests)
#   macOS:  xcode-select --install
#   Linux:  sudo apt install build-essential
# Bootstrap Go — a released toolchain used to compile the tree.
#   make.bash finds one automatically (~/sdk/goN.M, ~/go1.4); override with
#   the `go-std-goroot-bootstrap' variable if yours lives elsewhere.
#   macOS:  brew install go
#   Linux:  sudo apt install golang-go     # or the tarball from https://go.dev/dl
# perflock — stable benchmark timings (LINUX ONLY; no macOS equivalent)
#   Linux:  go install github.com/aclements/perflock/cmd/perflock@latest
```

### C / C++ (LLVM — clangd LSP, clang-tidy lint, lldb-dap debug)

```sh
#   macOS:  brew install llvm
#           echo 'export PATH="/opt/homebrew/opt/llvm/bin:$PATH"' >> ~/.zshrc
#   Linux:  sudo apt install clangd clang-tidy lldb      # or the llvm.org apt packages
```

### Python (cross-platform via uv)

```sh
uv tool install ruff                                    # format-on-save + lint
uv tool install "python-lsp-server[all]" --with python-lsp-ruff   # LSP (pylsp) + ruff lint
# debugging (dap-debug) — install into the PROJECT venv, not globally:
uv pip install debugpy        # or: pip install debugpy
```

### Assembly (amd64 / arm64)

```sh
cargo install asm-lsp        # LSP for x86-64 + AArch64 (cross-platform; needs Rust)
# nasm — assembler for building .asm sources (optional)
#   macOS:  brew install nasm
#   Linux:  sudo apt install nasm
```

### WebAssembly

`.wat`/`.wast` files always open in a WebAssembly mode: `wat-ts-mode` when the
tree-sitter grammar is installed, otherwise the built-in `wat-mode` fallback.
Everything below is optional — the fallback mode and, separately, the language
server each work without the other.

```sh
# wat_server — WAT language server (g-plane/wasm-language-tools)
#   macOS/Linux (cargo):  cargo install wat_server
#   or prebuilt binaries: https://github.com/g-plane/wasm-language-tools/releases
#     (wat_server-{arm64,x86_64}-{macos,linux}.zip — unzip and put it on PATH)
# wasmtime — run/debug compiled wasm (no Emacs DAP adapter for wasm)
#   macOS:  brew install wasmtime
#   Linux:  curl https://wasmtime.dev/install.sh -sSf | bash
# tree-sitter grammars — optional, upgrades wat-mode to wat-ts-mode.
# Needs a WORKING C toolchain; `treesit-install-language-grammar` shells out to `cc`:
#   macOS:  xcode-select --install    (verify with: cc --version && xcrun --find ld)
#   Linux:  sudo apt install build-essential
#   then in Emacs:  M-x treesit-install-language-grammar RET wat
#                   M-x treesit-install-language-grammar RET wast
```

### Infrastructure / config modes (LSP autostarts only if the server is present)

```sh
# terraform-ls
#   macOS:  brew install terraform-ls
#   Linux:  HashiCorp apt repo, then sudo apt install terraform-ls  (https://developer.hashicorp.com/terraform/install)
# cmake + cmake-language-server
#   macOS:  brew install cmake
#   Linux:  sudo apt install cmake
#   both:   uv tool install cmake-language-server
# yaml / json / dockerfile servers (cross-platform via npm; need Node):
npm install -g yaml-language-server                     # yaml
npm install -g vscode-langservers-extracted             # json (vscode-json-language-server)
npm install -g dockerfile-language-server-nodejs        # dockerfile (docker-langserver)
```

### Markdown

```sh
# pandoc — markdown-command (preview/export)
#   macOS:  brew install pandoc
#   Linux:  sudo apt install pandoc
```

### LaTeX (AUCTeX + texlab)

`.tex` and `.bib` buffers use AUCTeX and start the `texlab` language server **when
`texlab` is installed** — without it they open normally, with no prompt. `latexmk` is
the default build command (`C-c C-c`). Each file is treated as its own master
(`TeX-master` defaults to `t`, so there is no prompt on open); for a multi-file
document, add a file-local `%%% TeX-master: "main.tex"` block to the child files
(`C-c _` writes it for you). On macOS the PDF viewer is wired to
[Skim](https://skim-app.sourceforge.io) for forward/inverse search — on Linux, set
`TeX-view-program-selection` to your viewer (e.g. zathura) in `system_type/gnu_linux.el`.

```sh
# texlab — LaTeX language server
#   macOS:  brew install texlab
#   Linux:  sudo apt install texlab        # or: cargo install --locked texlab
#           (or a prebuilt binary: https://github.com/latex-lsp/texlab/releases)
# TeX distribution + latexmk
#   macOS:  brew install --cask mactex      # or basictex for a small install
#           brew install --cask skim        # PDF viewer used for SyncTeX
#   Linux:  sudo apt install texlive-full latexmk   # or texlive-latex-recommended
```

### Coding agents (init-agent.el)

Install whichever you use; `agent-start` launches any of them. These are
cross-platform (npm needs Node, aider uses uv). Verify package names against
each project — they change.

```sh
npm install -g @anthropic-ai/claude-code   # claude
uv tool install aider-chat                  # aider
npm install -g @openai/codex                # codex
npm install -g @google/gemini-cli           # gemini
```
