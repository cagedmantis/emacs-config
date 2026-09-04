;;; lang-wasm.el --- WebAssembly configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; WebAssembly text format (.wat) and script (.wast) editing, aligned with the
;; other lang-*.el configs:
;;   - major modes: `wat-ts-mode' / `wat-ts-wast-mode' (tree-sitter) when the
;;     grammars are installed, otherwise `wat-mode' -- a small fallback derived
;;     from `lisp-data-mode' (WAT is S-expression syntax with `;' comments)
;;   - completion, diagnostics and formatting via `wat_server'
;;     (g-plane/wasm-language-tools) through lsp-mode's lsp-wat client
;;   - format-on-save via the server (lsp-format-buffer)
;;
;; `.wat'/`.wast' are always routed through the dispatchers below, so opening
;; one never lands in `fundamental-mode': tree-sitter is used when it is
;; actually available (Emacs 29+ *and* a compiled `wat'/`wast' grammar, see
;; init-treesit.el and `M-x treesit-install-language-grammar'), and `wat-mode'
;; covers every other case -- the 28.2 floor, and any machine where the
;; grammars have not been built.  The language server is independent of
;; tree-sitter and attaches in either mode; it autostarts only when
;; `wat_server' is on PATH.
;;
;; Debugging: there is no standard Emacs DAP adapter for WebAssembly.  Debug
;; compiled wasm via its runtime instead -- e.g. `wasmtime' (which supports
;; gdb/lldb), or browser devtools for wasm running in a browser.

;;; Code:

(declare-function lsp-deferred "lsp-mode")
(declare-function lsp-format-buffer "lsp-mode")
(defvar lsp-language-id-configuration)

;;; Fallback major mode (no tree-sitter grammar required)

(defconst lang-wasm-keywords
  '("module" "func" "param" "result" "local" "global" "type" "start"
    "table" "memory" "elem" "data" "import" "export" "offset" "align"
    "mut" "block" "loop" "if" "then" "else" "end" "br" "br_if" "br_table"
    "call" "call_indirect" "return" "select" "drop" "nop" "unreachable"
    "i32" "i64" "f32" "f64" "v128" "funcref" "externref")
  "WAT keywords highlighted by `wat-mode'.")

;;;###autoload
(define-derived-mode wat-mode lisp-data-mode "WAT"
  "Major mode for WebAssembly text format, without tree-sitter.

A thin layer over `lisp-data-mode': WAT is S-expression syntax with
`;' line comments, so parens, motion and indentation already work.
Used when the `wat' tree-sitter grammar is unavailable; `wat-ts-mode'
is preferred when it is.  The `wat_server' language server attaches to
this mode too."
  (setq-local comment-start ";; ")
  (setq-local comment-start-skip ";;+ *")
  (font-lock-add-keywords
   nil
   `((,(concat "(\\s-*\\(" (regexp-opt lang-wasm-keywords) "\\)\\_>")
      1 font-lock-keyword-face)
     ;; $identifiers: functions, locals, labels, types.
     ("\\$[^][ \t\n()\"]+" . font-lock-variable-name-face))))

;;; Tree-sitter modes, when the grammars are there

(when (and (fboundp 'treesit-available-p) (treesit-available-p))
  (use-package wat-ts-mode
    :ensure t
    :commands (wat-ts-mode wat-ts-wast-mode)))

(defun lang-wasm--mode (lang ts-mode)
  "Enable TS-MODE if the LANG tree-sitter grammar is ready, else `wat-mode'."
  (if (and (fboundp 'treesit-ready-p)
           (fboundp ts-mode)
           (treesit-ready-p lang t))
      (funcall ts-mode)
    (wat-mode)))

;;;###autoload
(defun lang-wasm-wat ()
  "Open a WebAssembly text file in `wat-ts-mode', or `wat-mode' as fallback."
  (interactive)
  (lang-wasm--mode 'wat 'wat-ts-mode))

;;;###autoload
(defun lang-wasm-wast ()
  "Open a WebAssembly script file in `wat-ts-wast-mode', or `wat-mode'."
  (interactive)
  (lang-wasm--mode 'wast 'wat-ts-wast-mode))

(add-to-list 'auto-mode-alist '("\\.wat\\'" . lang-wasm-wat))
(add-to-list 'auto-mode-alist '("\\.wast\\'" . lang-wasm-wast))

;;; Language server (works with or without tree-sitter)

;; Tell lsp-mode these buffers are language "wat" so the lsp-wat client
;; (server-id wat_server, which activates on language "wat") attaches.
(with-eval-after-load 'lsp-mode
  (dolist (mode '(wat-mode wat-ts-mode wat-ts-wast-mode))
    (add-to-list 'lsp-language-id-configuration (cons mode "wat"))))

;; Auto-start the WAT language server, and format on save, only when the
;; server is installed.
(defun lang-wasm--maybe-lsp ()
  "Start `lsp' and enable format-on-save when `wat_server' is on PATH."
  (when (executable-find "wat_server")
    (lsp-deferred)
    (add-hook 'before-save-hook #'lsp-format-buffer nil t)))

(dolist (hook '(wat-mode-hook wat-ts-mode-hook wat-ts-wast-mode-hook))
  (add-hook hook #'lang-wasm--maybe-lsp))

(provide 'lang-wasm)
;;; lang-wasm.el ends here
