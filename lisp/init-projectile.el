(use-package projectile
  :ensure t
  :config
  (projectile-global-mode)

  ;;enable caching unconditionally
  (setq projectile-enable-caching t)
  )

(provide 'init-projectile)
