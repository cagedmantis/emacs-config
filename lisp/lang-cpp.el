;;; lang-cpp.el --- C/C++ configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Modern C/C++ setup built on clangd (LLVM), aligned with lang-go.el:
;;   - completion, navigation and diagnostics via clangd + lsp-mode
;;   - clang-tidy linting (through clangd's --clang-tidy flag)
;;   - format-on-save via clangd (LLVM / .clang-format style)
;;   - debugging via dap-mode + LLDB (dap-lldb)
;;
;; Replaces the previous irony-mode / company-irony / flycheck-irony stack.
;; Requires LLVM tools on PATH: `clangd' (completion/lint/format) and, for
;; debugging, `lldb-dap' (older LLVM ships it as `lldb-vscode').
;; exec-path-from-shell makes them discoverable in GUI/daemon sessions.

;;; Code:

(declare-function lsp-deferred "lsp-mode")
(defvar lsp-clients-clangd-args)        ; defined in lsp-clangd
(defvar dap-lldb-debug-program)         ; defined in dap-lldb

;; clangd invocation: enable clang-tidy linting, richer completion and a
;; background index.  Set before clangd starts; a defcustom won't clobber it.
(setq lsp-clients-clangd-args
      '("--clang-tidy"
        "--header-insertion=never"
        "--completion-style=detailed"
        "--background-index"))

(use-package cc-mode
  :ensure nil  ; built-in
  ;; c-mode-base-map is the common ancestor of c-mode-map / c++-mode-map, so
  ;; these bindings (mirroring lang-go.el) apply to both C and C++.
  :bind (:map c-mode-base-map
              ("C-c r" . lsp-rename)
              ("C-c j" . lsp-find-definition)
              ("C-c d" . lsp-describe-thing-at-point)
              ("C-c ," . lsp-find-references)
              ("C-c i" . lsp-find-implementation)
              ("C-c t" . lsp-find-type-definition)
              ("C-c s" . lsp-execute-code-action)
              ;; Switch between header and implementation (clangd extension).
              ("C-c o" . lsp-clangd-find-other-file))
  :config
  ;; Start clangd in C/C++ buffers (unconditional, daemon-safe -- same
  ;; rationale as lang-go.el).
  (defun lang-cpp--setup ()
    "Buffer-local C/C++ editing settings."
    (subword-mode 1)
    (setq-local c-basic-offset 4
                indent-tabs-mode nil))

  (defun lang-cpp-before-save-hooks ()
    "Format C/C++ buffers on save, via clangd."
    (add-hook 'before-save-hook #'lsp-format-buffer t t))

  (dolist (hook '(c-mode-hook c++-mode-hook))
    (add-hook hook #'lsp-deferred)
    (add-hook hook #'lang-cpp--setup)
    (add-hook hook #'lang-cpp-before-save-hooks))

  ;; Debugging: load the LLDB adapter once dap-mode is available and point it
  ;; at LLVM's lldb-dap (older LLVM names it lldb-vscode).  M-x dap-debug.
  (with-eval-after-load 'dap-mode
    (require 'dap-lldb)
    (setq dap-lldb-debug-program
          (list (or (executable-find "lldb-dap")
                    (executable-find "lldb-vscode")
                    "lldb-dap")))))

(provide 'lang-cpp)
;;; lang-cpp.el ends here
