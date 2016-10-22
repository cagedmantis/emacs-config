;;(setq company-idle-delay nil)

(setq gofmt-command "goimports")
;; UPDATE: gofmt-before-save is more convenient then having a command
;; for running gofmt manually. In practice, you want to
;; gofmt/goimports every time you save anyways.
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
  ;; UPDATE: I commented the next line out because it isn't needed
  ;; with the gofmt-before-save hook above.
  ;; (local-set-key (kbd "C-c m") 'gofmt)
  (local-set-key (kbd "M-.") 'godef-jump))

(set (make-local-variable 'company-backends) '(company-go))  ;;)

(add-hook 'go-mode-hook 'my-go-mode-hook)
;;(add-hook 'go-mode-hook 'go-eldoc-setup)
;;(add-hook 'go-mode-hook 'company-mode)

(provide 'init-go)
