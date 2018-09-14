;;; init-ivy.el --- ivy configuration init

;;; Commentary:

;;; Code:

(use-package ivy
  :ensure t
  :diminish ivy-mode
  :bind (("C-c C-r" . ivy-resume)
         ("C-x b" . ivy-switch-buffer)
         ("C-x B" . ivy-switch-buffer-other-window))
  :config

  (use-package counsel
	:ensure t
	:diminish counsel-mode
	:bind (("C-x C-f" . counsel-find-file)
           ("M-x" . counsel-M-x)
           ("M-y" . counsel-yank-pop)))

  (if (version< emacs-version "26")
	  (message "version does not support ivy-posframe")
	(use-package ivy-posframe
	  :ensure t
	  :config
	  (require 'ivy-posframe)
	  (setq ivy-display-function #'ivy-posframe-display)))

  (ivy-mode 1)

  ;; Add recent files and bookmarks to the ivy-switch-buffer
  (setq ivy-use-virtual-buffers t)

  ;; Displays the current and total number in the collection in the prompt
  (setq ivy-count-format "%d/%d ")

  (setq ivy-height 10)
  (setq ivy-virtual-abbreviate 'full) ; Show the full virtual file paths
  (setq ivy-extra-directories 'nil) ; default value: ("../" "./")
  (setq ivy-wrap t)
  (setq ivy-re-builders-alist '((t . ivy--regex-plus)))

  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy)
  (setq ivy-initial-inputs-alist nil)

  (setq ivy-re-builders-alist
		'((ivy-switch-buffer . ivy--regex-plus)
		  (swiper . ivy--regex-plus)
		  (t . ivy--regex-fuzzy)))

  ;; (setq enable-recursive-minibuffers t)

  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)

  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)

  (global-set-key (kbd "C-c C-r") 'ivy-resume))

;; Let ivy use flx for fuzzy-matching
;; (use-package flx
;; 	:ensure t
;; 	:config
;; 	(require 'flx)
;; 	(setq ivy-re-builders-alist '((t . ivy--regex-fuzzy))))

;; Let projectile use ivy
;;(setq projectile-completion-system 'ivy)

;; (use-package ivy-rich
;;   :after ivy
;;   :custom
;;   (ivy-virtual-abbreviate 'full
;;                           ivy-rich-switch-buffer-align-virtual-buffer t
;;                           ivy-rich-path-style 'abbrev)
;;   :config
;;   (ivy-set-display-transformer 'ivy-switch-buffer
;;                                'ivy-rich-switch-buffer-transformer))

(provide 'init-ivy)

;;; init-ivy.el ends here
