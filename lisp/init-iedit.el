(use-package iedit
  :ensure t
  :config

  (define-key global-map (kbd "C-c ;") 'iedit-mode))

(provide 'init-iedit)
