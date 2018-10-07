;;; lang-go.el --- lang-go configuration

;;; Commentary:

;;; Code:

(use-package go-mode
  :ensure t
  :config

  (setq gofmt-command "goimports")

  (use-package go-projectile
    :ensure t)

  (use-package godoctor
    :ensure t)

  (use-package go-add-tags
	:ensure t
	:config
	(global-set-key (kbd "C-c t") 'go-add-tags))

  (use-package go-guru
    :ensure t
    :config
    (add-hook `go-mode-hook `go-guru-hl-identifier-mode))

  ;; (use-package go-eldoc
  ;;   :ensure t
  ;;   :config
  ;;   (add-hook 'go-mode-hook 'go-eldoc-setup)
  ;;   (set-face-attribute 'eldoc-highlight-function-argument nil
  ;;                       :underline t
  ;;                       :foreground "green"
  ;;                       :weight 'bold))

  (use-package go-fill-struct
	:ensure t)

  (use-package go-errcheck
	:ensure t)

  (use-package go-gen-test
	:ensure t)

  (use-package gotest
	:ensure t)

  (use-package go-stacktracer
	:ensure t)

  (use-package go-direx
	:ensure t)

  (use-package company-go
	:ensure company
	:defer t
	:config

	(add-hook 'go-mode-hook 'company-mode)
	(add-to-list 'company-backends 'company-go)
	(global-set-key (kbd "C-c M-n") 'company-complete)
	(global-set-key (kbd "C-c C-n") 'company-complete)

	(setq company-idle-delay .3)
	(setq company-minimum-prefix-length 1)
	(setq company-begin-commands '(self-insert-command))

	;; (add-hook 'go-mode-hook (lambda ()
    ;;                           (set (make-local-variable 'company-backends) '(company-go))
    ;;                           (company-mode)))
	)

  (defun my-go-mode-hook ()
	(subword-mode t)
	(setq tab-width 4)
	(add-hook 'before-save-hook 'gofmt-before-save)
	(with-eval-after-load 'go-mode
	  (require 'godoctor)
	  (require 'go-guru)
	  (go-guru-hl-identifier-mode))

	(add-hook 'go-mode-hook 'flycheck-mode)
	)
  (add-hook 'go-mode-hook 'my-go-mode-hook)
  )

;; modified from github.com/dougm/go-projectile

(defvar go-tools
  '((gocode      . "github.com/mdempsky/gocode")
	;;(gocode      . "github.com/stamblerre/gocode")
	(gotags      . "github.com/jstemmer/gotags")
	(errcheck    . "github.com/kisielk/errcheck")
	(fillstruct  . "github.com/davidrjenni/reftools/cmd/fillstruct")
	(godef       . "github.com/rogpeppe/godef")
	(godoc       . "golang.org/x/tools/cmd/godoc")
	(goflymake   . "github.com/dougm/goflymake")
	(gogetdoc    . "github.com/zmb3/gogetdoc")
	(goimports   . "golang.org/x/tools/cmd/goimports")
	(goimports   . "golang.org/x/tools/cmd/goimports")
	(golint      . "github.com/golang/lint/golint")
	(gomegacheck . "honnef.co/go/tools/cmd/megacheck")
	(gomvpkg     . "golang.org/x/tools/cmd/gomvpkg")
	(gorename    . "golang.org/x/tools/cmd/gorename")
	(gotests     . "go get -u github.com/cweill/gotests")
	(gounconvert . "github.com/mdempsky/unconvert")
	(guru        . "golang.org/x/tools/cmd/guru"))
  "Import paths for My Go tools.")

(defun go-get-tools ()
  "Install go related tools via go get."
  (dolist (tool go-tools)
    (let* ((url (cdr tool))
           (cmd (concat "go get -u " url))
           (result (shell-command-to-string cmd)))
      (message "Go tool %s: %s" (car tool) cmd))))

(defun go-update-tools ()
  "Update go related tools."
  (interactive)
  (go-get-tools))

(provide 'lang-go)

;;; lang-go.el ends here
