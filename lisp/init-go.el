;;; init-go.el --- go configuration

;;; Commentary:

;;; Code:

(use-package go-mode
  :ensure t
  :config
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

  (use-package go-eldoc
    :ensure t
    :config
    (add-hook 'go-mode-hook 'go-eldoc-setup)
    (set-face-attribute 'eldoc-highlight-function-argument nil
                        :underline t
                        :foreground "green"
                        :weight 'bold))

  (use-package go-fill-struct
	:ensure t)

  (use-package go-errcheck
    :ensure t)

  (use-package go-gen-test
	:ensure t)

  (use-package gotest
	:ensure t)

  (use-package company-go
    :ensure company
    :init

    (add-hook 'go-mode-hook 'company-mode)
    (add-hook 'go-mode-hook (lambda ()
                              (set (make-local-variable 'company-backends) '(company-go))
                              (company-mode)))

    (global-set-key (kbd "C-c M-n") 'company-complete)
    (global-set-key (kbd "C-c C-n") 'company-complete)

	(add-to-list 'company-backends 'company-go)

	(add-hook 'go-mode-hook 'flycheck-mode)
	)

  (defun my-go-mode-hook ()
    (setq gofmt-command "goimports")
    (linum-mode t)
    (subword-mode t)
    (setq tab-width 4)
    (add-hook 'before-save-hook 'gofmt-before-save)
    (with-eval-after-load 'go-mode
      ;;(require 'go-autocomplete)
      (require 'godoctor)
      (require 'go-guru)
      (go-guru-hl-identifier-mode)))
  (add-hook 'go-mode-hook 'my-go-mode-hook)
  )

;; modified from github.com/dougm/go-projectile

(defvar go-tools
  '((gocode      . "github.com/mdempsky/gocode")
    (golint      . "github.com/golang/lint/golint")
    (godef       . "github.com/rogpeppe/godef")
    (errcheck    . "github.com/kisielk/errcheck")
    (godoc       . "golang.org/x/tools/cmd/godoc")
    (gogetdoc    . "github.com/zmb3/gogetdoc")
    (goimports   . "golang.org/x/tools/cmd/goimports")
    (gorename    . "golang.org/x/tools/cmd/gorename")
    (gomvpkg     . "golang.org/x/tools/cmd/gomvpkg")
    (guru        . "golang.org/x/tools/cmd/guru")
    (gomegacheck . "honnef.co/go/tools/cmd/megacheck")
    (gounconvert . "github.com/mdempsky/unconvert")
    (goflymake   . "github.com/dougm/goflymake")
    (goimports   . "golang.org/x/tools/cmd/goimports")
    (gotests     . "go get -u github.com/cweill/gotests")
    (fillstruct  . "github.com/davidrjenni/reftools/cmd/fillstruct"))
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

(provide 'init-go)

;;; init-go.el ends here
