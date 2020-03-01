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
	(add-hook 'before-save-hook 'gofmt-before-save)
	(with-eval-after-load 'go-mode
	  ;; (require 'godoctor)
	  ;; (require 'go-guru)
	  (go-guru-hl-identifier-mode))

	;;todo: cleanup
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

;; (use-package go-guru
;;   :ensure t
;;   :after go-mode
;;   :config
;;   (add-hook `go-mode-hook `go-guru-hl-identifier-mode))

;; (use-package godoctor
;;   :ensure t
;;   :after go-mode)

(use-package go-projectile
  :ensure t
  :after (go-mode projectile))

(use-package go-impl
  :ensure t
  :after go-mode)

(use-package go-tag
  :ensure t
  :after go-mode)

;; TODO: add dap-mode, dap-go

;; modified from github.com/dougm/go-projectile

(defvar go-tools
  '((asmfmt        . "github.com/klauspost/asmfmt/cmd/asmfmt")
	(errcheck      . "github.com/kisielk/errcheck")
	(fillstruct    . "github.com/davidrjenni/reftools/cmd/fillstruct")
	(godoc         . "golang.org/x/tools/cmd/godoc")
	(goflymake     . "github.com/dougm/goflymake")
	(gogetdoc      . "github.com/zmb3/gogetdoc")
	(golint        . "github.com/golang/lint/golint")
	(gomodifytags  . "github.com/fatih/gomodifytags")
	(gomvpkg       . "golang.org/x/tools/cmd/gomvpkg")
	(gopls         . "golang.org/x/tools/gopls@latest") ;; enable modules
	(gotags        . "github.com/jstemmer/gotags")
	(gotests       . "github.com/cweill/gotests")
	(gounconvert   . "github.com/mdempsky/unconvert")
	(impl          . "github.com/josharian/impl")
	(staticcheck   . "honnef.co/go/gools/cmd/staticcheck"))
  "Import paths for My Go tools.")

;; TODO: consider adding a way to set GO111MODULE=on for individual commands.

(defun go-get-tools ()
  "Install go related tools via go get."
  (dolist (tool go-tools)
    (let* ((url (cdr tool))
           (cmd (concat "go get -u " url))
           (result (shell-command-to-string cmd)))
      (message "Go tool %s: %s" (car tool) cmd))))

(defun go-update-tools ()
  "Update go related tools via go get."
  (interactive)
  (go-get-tools))

(provide 'lang-go)

;;; lang-go.el ends here
