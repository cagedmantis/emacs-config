;;; lang-python.el --- Python configuration  -*- lexical-binding: t; -*-

;;; Commentary:
;; Modern Python setup aligned with the other lang-*.el configs:
;;   - completion, navigation, types and diagnostics via lsp-mode; the server
;;     is auto-detected (whatever is installed: pylsp, ruff, jedi, or pyright
;;     via the optional lsp-pyright package)
;;   - ruff for format-on-save and linting (install `ruff')
;;   - debugging via dap-mode + debugpy (dap-python)
;;
;; Replaces the previous elpy / py-autopep8 stack.  Keybindings mirror
;; lang-go.el / lang-cpp.el.

;;; Code:

(declare-function lsp-deferred "lsp-mode")
(defvar dap-python-debugger)

;; reformatter defines `ruff-format-on-save-mode' (and ruff-format-buffer).
(use-package reformatter
  :ensure t
  :config
  (reformatter-define ruff-format
    :program "ruff"
    :args (list "format" "--stdin-filename" (or (buffer-file-name) "stdin.py") "-")))

(use-package python
  :ensure nil  ; built-in
  :bind (:map python-mode-map
              ("C-c r" . lsp-rename)
              ("C-c j" . lsp-find-definition)
              ("C-c d" . lsp-describe-thing-at-point)
              ("C-c ," . lsp-find-references)
              ("C-c i" . lsp-find-implementation)
              ("C-c t" . lsp-find-type-definition)
              ("C-c s" . lsp-execute-code-action))
  :config
  ;; Start LSP (unconditional/daemon-safe, like lang-go/lang-cpp); lsp-mode
  ;; selects whichever Python server is installed.
  (add-hook 'python-mode-hook #'lsp-deferred)

  (defun lang-python--setup ()
    "Buffer-local Python settings."
    (subword-mode 1)
    (setq-local fill-column 88))   ; ruff/black default line length
  (add-hook 'python-mode-hook #'lang-python--setup)

  ;; ruff format-on-save, only when ruff is installed.
  (add-hook 'python-mode-hook
            (lambda () (when (executable-find "ruff") (ruff-format-on-save-mode))))

  ;; Debugging via debugpy (M-x dap-debug).
  (with-eval-after-load 'dap-mode
    (require 'dap-python)
    (setq dap-python-debugger 'debugpy)))

(provide 'lang-python)
;;; lang-python.el ends here
