;;; init-rust.el --- rust configuration

;;; Commentary:

;;; Code:

(use-package rust-mode
  :ensure t
  :config

  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
  (setq rust-format-on-save t)

  (use-package flycheck-rust
	:ensure t
	:config
	(add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

  (use-package racer
	:ensure company-mode
	:config
	(add-hook 'racer-mode-hook #'company-mode)
	(add-hook 'rust-mode-hook #'racer-mode)
	(add-hook 'racer-mode-hook #'eldoc-mode)

	(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
	(setq company-tooltip-align-annotations t))

  (use-package cargo
	:ensure t))

;; rustup component add rust-src
;; rustup component add rust-docs

;; ;; rustup toolchain install nightly
;; ;; rustup override set nightly

;; rustup run nightly cargo install clippy
;; rust-clippy

;; -cargo install rustfmt
;; rustfmt


;; cargo install racer
;; racer


;; rls

;; rustup update

;; (defvar rust-tools
;;   '((gocode      . "github.com/nsf/gocode")
;;     (golint      . "github.com/golang/lint/golint")
;;     (godef       . "github.com/rogpeppe/godef")
;;     (errcheck    . "github.com/kisielk/errcheck")
;;     (godoc       . "golang.org/x/tools/cmd/godoc")
;;     (gogetdoc    . "github.com/zmb3/gogetdoc")
;;     (goimports   . "golang.org/x/tools/cmd/goimports")
;;     (gorename    . "golang.org/x/tools/cmd/gorename")
;;     (gomvpkg     . "golang.org/x/tools/cmd/gomvpkg")
;;     (guru        . "golang.org/x/tools/cmd/guru")
;;     (gomegacheck . "honnef.co/go/tools/cmd/megacheck")
;;     (gounconvert . "github.com/mdempsky/unconvert")
;;     (goflymake   . "github.com/dougm/goflymake")
;;     (goimports   . "golang.org/x/tools/cmd/goimports")
;;     (fillstruct  . "github.com/davidrjenni/reftools/cmd/fillstruct"))
;;   "Import paths for My Go tools.")

;; (defun rust-up-tools ()
;;   "Install go related tools via go get."
;;   (dolist (tool rust-tools)
;;     (let* ((url (cdr tool))
;;            (cmd (concat "go get -u " url))
;;            (result (shell-command-to-string cmd)))
;;       (message "Go tool %s: %s" (car tool) cmd))))

;; (defun go-update-tools ()
;;   "Update go related tools."
;;   (interactive)
;;   (go-get-tools))

(provide 'init-rust)


;;; init-rust.el ends here
