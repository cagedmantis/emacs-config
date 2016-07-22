(require 'projectile)

;;enable projectile globally
(projectile-global-mode)

;;enable caching unconditionally
(setq projectile-enable-caching t)

;; (require 'projectile-direnv)
;; (add-hook 'projectile-mode-hook 'projectile-direnv-export-variables)

(provide 'init-projectile)
