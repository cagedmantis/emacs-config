(use-package go-mode
  :ensure go-mode
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

  (use-package go-errcheck
    :ensure t)

  (use-package company-go 
	;;:disabled
	:ensure t
	:init
	(use-package company
	  :config
	  (setq company-tooltip-limit 20)                      ; bigger popup window
	  ;;(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
	  (setq company-idle-delay nil)

	  (setq company-echo-delay 0)                          ; remove annoying blinking
	  (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing

	  (custom-set-faces
	   '(company-preview
		 ((t (:foreground "darkgray" :underline t))))
	   '(company-preview-common
		 ((t (:inherit company-preview))))
	   '(company-tooltip
		 ((t (:background "lightgray" :foreground "black"))))
	   '(company-tooltip-selection
		 ((t (:background "steelblue" :foreground "white"))))
	   '(company-tooltip-common
		 ((((type x)) (:inherit company-tooltip :weight bold))
		  (t (:inherit company-tooltip))))
	   '(company-tooltip-common-selection
		 ((((type x)) (:inherit company-tooltip-selection :weight bold))
		  (t (:inherit company-tooltip-selection)))))
	  )

	(add-hook 'go-mode-hook 'company-mode)
	(add-hook 'go-mode-hook (lambda ()
							  (set (make-local-variable 'company-backends) '(company-go))
							  (company-mode)))

	(global-set-key (kbd "C-c M-n") 'company-complete)
	(global-set-key (kbd "C-c C-n") 'company-complete)

	(set (make-local-variable 'company-backends) '(company-go)))

  (defun my-go-mode-hook ()
    (setq gofmt-command "goimports")
    (linum-mode t)
    (subword-mode t)
    (setq tab-width 4)
    (add-hook 'before-save-hook 'gofmt-before-save)
    (auto-complete-mode nil)
    (with-eval-after-load 'go-mode
      (require 'go-autocomplete)
      (require 'godoctor)
      (require 'go-guru)
      (go-guru-hl-identifier-mode)))
  (add-hook 'go-mode-hook 'my-go-mode-hook)
  )

;; TODO try gometalinter

(provide 'init-go)
