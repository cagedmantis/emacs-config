;;; init-projectile.el --- Projectile configuration init

;;; Commentary:

;;; Code:

(use-package projectile
  :ensure t
  :diminish
  ;;:pin melpa-stable
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-enable-caching t)
  (projectile-mode +1))

(provide 'init-projectile)

;;; init-projectile.el ends here
