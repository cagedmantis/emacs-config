(add-hook 'after-init-hook #'global-flycheck-mode)

(add-hook 'sh-mode-hook 'flycheck-mode)
(provide 'init-flycheck)
