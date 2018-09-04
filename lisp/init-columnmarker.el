;; (use-package column-marker
;;   :ensure t
;;   :config
  
;;   (add-hook 'php-mode-hook (lambda () (interactive) (column-marker-1 80)))
;;   (add-hook 'go-mode-hook (lambda () (interactive) (column-marker-2 80)))
;; )

(use-package fill-column-indicator
  :ensure t)

(provide 'init-columnmarker)
