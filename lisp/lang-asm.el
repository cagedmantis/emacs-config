;;; lang-asm.el --- Assembly configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Assembly editing for modern amd64 (x86-64) and arm64 (AArch64), aligned
;; with the other lang-*.el configs:
;;   - GAS / AT&T syntax (.s/.S, used by both amd64 and arm64) -> built-in
;;     `asm-mode'
;;   - NASM / Intel syntax (.asm/.nasm, amd64) -> `nasm-mode'
;;   - completion, hover and diagnostics via `asm-lsp' (lsp-mode's lsp-asm
;;     client), which supports x86/x86-64 and ARM/AArch64.
;;
;; LSP autostarts only when the `asm-lsp' server is on PATH (install with
;; `cargo install asm-lsp'), so opening an asm file never prompts on a machine
;; without it.  asm-mode and nasm-mode are both in `lsp-asm-active-modes'.

;;; Code:

(declare-function lsp-deferred "lsp-mode")

(use-package nasm-mode
  :ensure t
  ;; Intel-syntax assembly (NASM); GAS/AT&T .s/.S stay on built-in `asm-mode'.
  :mode ("\\.nasm\\'" "\\.asm\\'"))

(use-package asm-mode
  :ensure nil  ; built-in (GAS / AT&T syntax)
  :mode ("\\.s\\'" "\\.S\\'")
  :config
  (defun lang-asm--setup ()
    "Buffer-local assembly settings."
    (setq-local tab-width 8
                indent-tabs-mode t))
  (add-hook 'asm-mode-hook #'lang-asm--setup))

;; Auto-start asm-lsp (x86-64 + AArch64) only when the server is installed.
(defun lang-asm--maybe-lsp ()
  "Start `lsp-deferred' when the asm-lsp server is on PATH."
  (when (executable-find "asm-lsp")
    (lsp-deferred)))

(dolist (hook '(asm-mode-hook nasm-mode-hook))
  (add-hook hook #'lang-asm--maybe-lsp))

(provide 'lang-asm)
;;; lang-asm.el ends here
