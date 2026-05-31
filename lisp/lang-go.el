;;; lang-go.el --- lang-go copnfiguration  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package go-mode
  :ensure t
  :bind (:map go-mode-map
              ("C-c C-n" . go-run)
              ("C-c ."   . go-test-current-test)
              ("C-c f"   . go-test-current-file)
              ("C-c a"   . go-test-current-project)
              ("C-c r"   . lsp-rename)
              ("C-c j"   . lsp-find-definition)
              ("C-c d"   . lsp-describe-thing-at-point)
              ("C-c ,"   . lsp-find-references)
              ("C-c i"   . lsp-find-implementation)
              ("C-c t"   . lsp-find-type-definition))
  :config
  ;; Go-specific LSP wiring.  gopls also starts via init-language-server.el's
  ;; lsp-deferred :hook (go-mode is in it); this explicit add-hook de-dups and
  ;; keeps intent local.  Use `lsp-deferred', never a direct `(lsp)', so
  ;; startup stays deferred and isn't triggered twice.
  (add-hook 'go-mode-hook #'lsp-deferred)

  (defun my-go-mode-hook ()
    "Buffer-local Go editing settings."
    (subword-mode t)
    (setq tab-width 4))
  (add-hook 'go-mode-hook #'my-go-mode-hook)

  (defun lsp-go-before-save-hooks ()
    "Format the buffer and organize imports on save, via gopls."
    (add-hook 'before-save-hook #'lsp-format-buffer t t)
    (add-hook 'before-save-hook #'lsp-organize-imports t t))
  (add-hook 'go-mode-hook #'lsp-go-before-save-hooks)

  ;; Debugging via dap-mode: load the Delve adapter once dap-mode is available.
  ;; Needs `dlv' on PATH (see `go-tools'); start a session with M-x dap-debug.
  (with-eval-after-load 'dap-mode
    (require 'dap-dlv-go)))

(use-package go-fill-struct
  :ensure t
  :after go-mode
  :bind (:map go-mode-map ("C-c s" . go-fill-struct)))

(use-package go-errcheck
  :ensure t
  :after go-mode)

(use-package gotest
  :ensure t
  :defer t)

(use-package go-stacktracer
  :ensure t
  :after go-mode)

(use-package go-add-tags
  :ensure t
  :after go-mode
  :bind (:map go-mode-map ("C-c T" . go-add-tags)))

(use-package go-impl
  :ensure t
  :after go-mode)

(use-package go-tag
  :ensure t
  :after go-mode)

;; modified from github.com/dougm/go-projectile

(defvar go-tools
  '((asmfmt        . "github.com/klauspost/asmfmt/cmd/asmfmt")
    (fillstruct    . "github.com/davidrjenni/reftools/cmd/fillstruct")
    (stress2       . "github.com/aclements/go-misc/stress2")
    (toolstash     . "golang.org/x/tools/cmd/toolstash")
    (stringer      . "golang.org/x/tools/cmd/stringer")
    (godoc         . "golang.org/x/tools/cmd/godoc")
    (golint        . "golang.org/x/lint/golint")
    (gomodifytags  . "github.com/fatih/gomodifytags")
    (gomvpkg       . "golang.org/x/tools/cmd/gomvpkg")
    (gopls         . "golang.org/x/tools/gopls")
    (dlv           . "github.com/go-delve/delve/cmd/dlv")
    (gotags        . "github.com/jstemmer/gotags")
    (gotests       . "github.com/cweill/gotests/...")
    (gounconvert   . "github.com/mdempsky/unconvert")
    (impl          . "github.com/josharian/impl")
    (errcheck      . "github.com/kisielk/errcheck")
    (staticcheck   . "honnef.co/go/tools/cmd/staticcheck"))
  "Import paths for My Go tools.")

(defun go-install-toolset ()
  "Install the latest versions of Go related tools via go install."
  (dolist (tool go-tools)
    (let* ((url (cdr tool))
           (cmd (concat "go install " url "@latest"))
           (result (shell-command-to-string cmd)))
      (message "Go tool %s: %s -> %s" (car tool) cmd (string-trim result))))
  (message "Done installing/updating Go Tools"))

(defun go-install-tools ()
  "Update/install Go related tools."
  (interactive)
  (go-install-toolset))

(provide 'lang-go)
;;; lang-go.el ends here
