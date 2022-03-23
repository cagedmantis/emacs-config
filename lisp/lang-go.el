;;; lang-go.el --- lang-go copnfiguration

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

			  ;; TODO: prove that these are useful
			  ("C-c n" . flymake-goto-next-error)
			  ("C-c p" . flymake-goto-prev-error)
			  ("C-c ," . lsp-find-references)
			  ("C-c i" . lsp-find-implementation)
			  ("C-c t" . lsp-find-type-definition))
  :config
  (add-hook 'go-mode-hook 'lsp-deferred)
  (defun my-go-mode-hook ()
	(subword-mode t)
	(setq tab-width 4)
	;;(add-hook 'before-save-hook 'gofmt-before-save)
	(with-eval-after-load 'go-mode
	  (go-guru-hl-identifier-mode))

	(lsp)
	(add-hook 'go-mode-hook 'flycheck-mode))

  (defun lsp-go-before-save-hooks ()
	(add-hook 'before-save-hook #'lsp-format-buffer t t)
	(add-hook 'before-save-hook #'lsp-organize-imports t t))

  (add-hook 'go-mode-hook 'my-go-mode-hook)
  (add-hook 'before-save-hook #'lsp-go-before-save-hooks))

(use-package go-fill-struct
  :ensure t
  :bind ("C-c f" . go-fill-struct)
  :after go-mode)

(use-package go-errcheck
  :ensure t
  :after go-mode)

(use-package go-gen-test
  :ensure t
  :after go-mode)

(use-package gotest
  :ensure t
  :defer t)

(use-package go-stacktracer
  :ensure t
  :after go-mode)

(use-package go-direx
  :ensure t
  :after go-mode)

(use-package go-add-tags
  :ensure t
  :after go-mode
  :config
  (global-set-key (kbd "C-c t") 'go-add-tags))

(use-package go-projectile
  :ensure t
  :after (go-mode projectile))

(use-package go-impl
  :ensure t
  :after go-mode)

(use-package go-tag
  :ensure t
  :after go-mode)

(use-package golint
  :ensure t)

;; TODO: add dap-mode, dap-go

;; modified from github.com/dougm/go-projectile

(defvar go-tools
  '((asmfmt        . "github.com/klauspost/asmfmt/cmd/asmfmt")
	(fillstruct    . "github.com/davidrjenni/reftools/cmd/fillstruct")
	(godoc         . "golang.org/x/tools/cmd/godoc")
	(golint        . "golang.org/x/lint/golint")
	(gomodifytags  . "github.com/fatih/gomodifytags")
	(gomvpkg       . "golang.org/x/tools/cmd/gomvpkg")
	(gopls         . "golang.org/x/tools/gopls")
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
