;;; init-projectile.el --- Projectile configuration init

;;; Commentary:

;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(use-package projectile
  :ensure t
  :diminish
  ;;:pin melpa-stable
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-enable-caching t)
  (projectile-mode +1))

;; (use-package projectile
;;   :ensure t
;;   :diminish
;;   :config
;;   (projectile-global-mode)

;;   ;;enable caching unconditionally
;;   (setq projectile-enable-caching t)
;;   )

(provide 'init-projectile)

;;; init-projectile.el ends here
