(use-package color-theme
  :ensure t
  :config
  (setq color-theme-is-global t)
  (color-theme-initialize)

  ;; (use-package zenburn-theme
  ;;   :ensure t
  ;;   :config
  ;;   (load-theme 'zenburn)
  ;;   )

  (use-package doom-themes
    :ensure t
    :config
    (load-theme 'doom-vibrant t)
    (doom-themes-org-config)
	;; (flycheck-error     :underline `(:style wave :color ,red))
    ;; (flycheck-warning   :underline `(:style wave :color ,yellow))
    ;; (flycheck-info      :underline `(:style wave :color ,green))
    )

  ;; (use-package monokai-theme
  ;;   :ensure t
  ;;       ;; :config
  ;;       ;; (load-theme 'monokai)
  ;;       )

  ;; (use-package underwater-theme
  ;;   :ensure t)
  ;; (use-package ample-theme
  ;;   :ensure t)
  ;; (use-package busybee-theme
  ;;   :ensure t
  ;;       ;; :config
  ;;       ;; (load-theme 'busybee t)
  ;;       )
  ;; (use-package danneskjold-theme
  ;;   :ensure t)
  ;; (use-package dracula-theme
  ;;   :ensure t)

  ;; (use-package atom-one-dark-theme
  ;;       :ensure t
  ;;       ;; :config
  ;;       ;; (load-theme 'atom-one-dark t)
  ;;       )

  ;; (use-package color-theme-sanityinc-tomorrow
  ;;   :ensure t
  ;; 	:config
  ;; 	(load-theme 'sanityinc-tomorrow-bright t)
  ;;   )
  )

(provide 'init-colortheme)
