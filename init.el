;;; init.el --- Emacs configuration init

;; Dotfiles
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

;; Backup (tilde) files
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; Keyboard shortcuts
(keymap-global-set "C-x t" 'comment-or-uncomment-region)
(global-set-key (kbd "C-x p") (lambda () (interactive) (other-window -1)))

;; Theme
(load-theme 'tango-dark t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;      init-package
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Automatically ensure packages are downloaded
(add-to-list 'load-path "~/.emacs.d/packages")
(package-initialize)

(use-package package :ensure t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;      lang-go
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Requires Go LSP (gopls), which you can install with
;; go install golang.org/x/tools/gopls@latest
(use-package lsp-mode :ensure t)
(use-package go-mode :ensure t)

(add-hook 'go-mode-hook 'lsp-deferred)
(add-hook 'go-mode-hook 'subword-mode)
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook (lambda ()
                          (setq tab-width 4)
                          ;; (flycheck-add-next-checker 'lsp 'go-vet)
                          ;; (flycheck-add-next-checker 'lsp 'go-staticcheck)
			  ))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;      lang-rust
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package rust-mode :ensure t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(provide 'init)
