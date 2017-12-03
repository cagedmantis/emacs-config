(use-package color-theme
  :ensure t
  :config
  (require 'color-theme)
  (setq color-theme-is-global t)
  (color-theme-initialize)

  ;; (use-package color-theme-approximate
  ;; 	:config
  ;; 	(color-theme-approximate-on))

  ;; (dolist (theme '(solarized-theme
  ;; 				   zenburn-theme
  ;; 				   ir-black-theme
  ;; 				   monokai-theme
  ;; 				   underwater-theme
  ;; 				   ample-theme
  ;; 				   busybee-theme
  ;; 				   danneskjold-theme
  ;; 				   dracula-theme
  ;; 				   color-theme-sanityinc-tomorrow))
  ;; 	(use-package theme
  ;; 	  :ensure t))

  
  (use-package solarized-theme
    :ensure t)
  (use-package zenburn-theme
    :ensure t)
  (use-package ir-black-theme
    :ensure t
	;; :config
	;; (load-theme 'ir-black)
)
  (use-package monokai-theme
    :ensure t
	;; :config
	;; (load-theme 'monokai)
)

  (use-package underwater-theme
    :ensure t)
  (use-package ample-theme
    :ensure t)
  (use-package busybee-theme
    :ensure t
	;; :config
	;; (load-theme 'busybee t)
	)
  (use-package danneskjold-theme
    :ensure t)
  (use-package dracula-theme
    :ensure t)

  (use-package atom-one-dark-theme
	:ensure t
	;; :config
	;; (load-theme 'atom-one-dark t)
	)

  (use-package color-theme-sanityinc-tomorrow
    :ensure t
	:config
	(load-theme 'sanityinc-tomorrow-bright t)
    )
  )

(provide 'init-colortheme)
