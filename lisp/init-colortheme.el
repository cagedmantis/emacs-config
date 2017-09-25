(use-package color-theme
  :ensure t
  :config
  (require 'color-theme)
  (setq color-theme-is-global t)
  (color-theme-initialize)

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
  	:ensure t)
  (use-package monokai-theme
  	:ensure t)
  (use-package underwater-theme
  	:ensure t)
  (use-package ample-theme
  	:ensure t)
  (use-package busybee-theme
  	:ensure t)
  (use-package danneskjold-theme
  	:ensure t)
  (use-package dracula-theme
  	:ensure t)
  (use-package color-theme-sanityinc-tomorrow
  	:ensure t)

  (load-theme 'sanityinc-tomorrow-bright t)
  )
(provide 'init-colortheme)
