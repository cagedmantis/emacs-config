
(require 'company)                                   ; load company mode
(require 'company-go)                                ; load company mode go backend
(setq company-tooltip-limit 20)                      ; bigger popup window
(setq company-idle-delay .3)                         ; decrease delay before autocompletion popup shows
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

(require 'go-guru)
(add-hook `go-mode-hook `go-guru-hl-identifier-mode)

(require 'go-add-tags)
(global-set-key (kbd "C-c t") 'go-add-tags)

;;gometalinter
;; (require 'flycheck-gometalinter)
;; (eval-after-load 'flycheck
;;   '(add-hook 'flycheck-mode-hook #'flycheck-gometalinter-setup))

;; ;; skips 'vendor' directories and sets GO15VENDOREXPERIMENT=1
;; (setq flycheck-gometalinter-vendor t)
;; ;; only run fast linters
;; ;;(setq flycheck-gometalinter-fast t)
;; ;; use in tests files
;; (setq flycheck-gometalinter-test t)
;; ;; disable linters
;; ;;(setq flycheck-gometalinter-disable-linters '("gotype" "gocyclo"))
;; ;; Only enable selected linters
;; ;;(setq flycheck-gometalinter-disable-all t)
;; ;;(setq flycheck-gometalinter-enable-linters '("golint"))
;; ;; Set different deadline (default: 5s)
;; (setq flycheck-gometalinter-deadline "10s")

(provide 'init-go)
