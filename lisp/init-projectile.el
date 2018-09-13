;;; init-projectile.el --- Projectile configuration init

;;; Commentary:

;;; Code:

(use-package projectile
  :ensure t
  :diminish
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (projectile-mode +1)

  ;;enable caching unconditionally
  (setq projectile-enable-caching t))

(provide 'init-projectile)

;;; init-projectile.el ends here
