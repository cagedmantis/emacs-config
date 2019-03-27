;;; lang-go.el --- lang-go configuration

;;; Commentary:

;;; Code:

(use-package go-mode
  :ensure t
  :bind ("C-c r" . go-rename)
  :config

  (setq gofmt-command "goimports")
  (setq gofmt-args '("-local" "do"))

  (defun my-go-mode-hook ()
	(subword-mode t)
	(setq tab-width 4)
	(add-hook 'before-save-hook 'gofmt-before-save)
	(with-eval-after-load 'go-mode
	  (require 'godoctor)
	  (require 'go-guru)
	  (go-guru-hl-identifier-mode))

	(add-hook 'go-mode-hook 'flycheck-mode))
  (add-hook 'go-mode-hook 'my-go-mode-hook))

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
  :after go-mode)

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

(use-package go-guru
  :ensure t
  :after go-mode
  :config
  (add-hook `go-mode-hook `go-guru-hl-identifier-mode))

(use-package godoctor
  :ensure t
  :after go-mode)

(use-package go-projectile
  :ensure t
  :after (go-mode projectile))

(use-package go-impl
  :ensure t
  :after go-mode)

(use-package go-tag
  :ensure t
  :after go-mode)

;; modified from github.com/dougm/go-projectile

(defvar go-tools
  '((errcheck      . "github.com/kisielk/errcheck")
	(asmfmt        . "github.com/klauspost/asmfmt/cmd/asmfmt")
	(fillstruct    . "github.com/davidrjenni/reftools/cmd/fillstruct")
	(gocode        . "github.com/mdempsky/gocode")
	(godef         . "github.com/rogpeppe/godef")
	(godoc         . "golang.org/x/tools/cmd/godoc")
	(goflymake     . "github.com/dougm/goflymake")
	(gogetdoc      . "github.com/zmb3/gogetdoc")
	(gogetdoc      . "github.com/zmb3/gogetdoc")
	(goimports     . "golang.org/x/tools/cmd/goimports")
	(golint        . "github.com/golang/lint/golint")
	;;(go-tools      . "honnef.co/go/tools/cmd/...")
	(gometalinter  . "github.com/alecthomas/gometalinter")
	(gomodifytags  . "github.com/fatih/gomodifytags")
	(gomvpkg       . "golang.org/x/tools/cmd/gomvpkg")
	(gorename      . "golang.org/x/tools/cmd/gorename")
	(gotags        . "github.com/jstemmer/gotags")
	(gotests       . "github.com/cweill/gotests")
	(gounconvert   . "github.com/mdempsky/unconvert")
	(guru          . "golang.org/x/tools/cmd/guru")
	(impl          . "github.com/josharian/impl")
	(bingo         . "github.com/saibing/bingo")
	(tools         . "honnef.co/go/tools"))
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
