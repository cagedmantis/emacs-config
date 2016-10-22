(setq gofmt-command "goimports")
(add-hook 'before-save-hook 'gofmt-before-save)

(add-hook 'go-mode-hook 'company-mode)
(add-hook 'go-mode-hook (lambda ()
						  (set (make-local-variable 'company-backends) '(company-go))
						  (company-mode)))

(add-hook 'go-mode-hook 'go-eldoc-setup)

;; Modify appearance of docs
(set-face-attribute 'eldoc-highlight-function-argument nil
                    :underline t
					:foreground "green"
                    :weight 'bold)

(global-set-key (kbd "C-c M-n") 'company-complete)
(global-set-key (kbd "C-c C-n") 'company-complete)

(defun my-go-mode-hook ()
  (local-set-key (kbd "M-.") 'godef-jump))

(set (make-local-variable 'company-backends) '(company-go))  ;;)

(add-hook 'go-mode-hook 'my-go-mode-hook)

(provide 'init-go)
