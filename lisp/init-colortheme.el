;;; init-colortheme.el --- Color theme configuration init

;;; Commentary:

;;; Code:

(use-package color-theme
  :ensure t
  :config
  (setq color-theme-is-global t)
  (color-theme-initialize)

  (use-package doom-themes
    :ensure t
    :config
    (load-theme 'doom-vibrant t)
    (doom-themes-org-config)))

(provide 'init-colortheme)

;;; init-colortheme.el ends here
