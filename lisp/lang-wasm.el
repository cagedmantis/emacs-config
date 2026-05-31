;;; lang-wasm.el --- WebAssembly configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; WebAssembly text format (.wat) and script (.wast) editing, aligned with the
;; other lang-*.el configs:
;;   - major modes: `wat-ts-mode' / `wat-ts-wast-mode' (tree-sitter)
;;   - completion, diagnostics and formatting via `wat_server'
;;     (g-plane/wasm-language-tools) through lsp-mode's lsp-wat client
;;   - format-on-save via the server (lsp-format-buffer)
;;
;; Requires Emacs 29+ (tree-sitter) and the `wat'/`wast' grammars, declared in
;; init-treesit.el (install with M-x treesit-install-language-grammar).  On the
;; 28.2 floor this whole module is skipped.  LSP autostarts only when
;; `wat_server' is on PATH.
;;
;; Debugging: there is no standard Emacs DAP adapter for WebAssembly.  Debug
;; compiled wasm via its runtime instead -- e.g. `wasmtime' (which supports
;; gdb/lldb), or browser devtools for wasm running in a browser.

;;; Code:

(declare-function lsp-deferred "lsp-mode")
(defvar lsp-language-id-configuration)

(when (and (fboundp 'treesit-available-p) (treesit-available-p))
  (use-package wat-ts-mode
    :ensure t
    :commands (wat-ts-mode wat-ts-wast-mode)
    :config
    ;; Tell lsp-mode these buffers are language "wat" so the lsp-wat client
    ;; (server-id wat_server, which activates on language "wat") attaches.
    (with-eval-after-load 'lsp-mode
      (add-to-list 'lsp-language-id-configuration '(wat-ts-mode . "wat"))
      (add-to-list 'lsp-language-id-configuration '(wat-ts-wast-mode . "wat")))

    ;; Auto-start the WAT language server, and format on save, only when the
    ;; server is installed.
    (defun lang-wasm--maybe-lsp ()
      (when (executable-find "wat_server")
        (lsp-deferred)
        (add-hook 'before-save-hook #'lsp-format-buffer nil t)))
    (add-hook 'wat-ts-mode-hook #'lang-wasm--maybe-lsp)
    (add-hook 'wat-ts-wast-mode-hook #'lang-wasm--maybe-lsp))

  ;; Only route files to the tree-sitter modes once the grammars are actually
  ;; installed, so opening a .wat without the grammar doesn't error.
  (when (treesit-ready-p 'wat t)
    (add-to-list 'auto-mode-alist '("\\.wat\\'" . wat-ts-mode)))
  (when (treesit-ready-p 'wast t)
    (add-to-list 'auto-mode-alist '("\\.wast\\'" . wat-ts-wast-mode))))

(provide 'lang-wasm)
;;; lang-wasm.el ends here
