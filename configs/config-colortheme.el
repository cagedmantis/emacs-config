;; Color Theme

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")




(add-to-list 'load-path
	     "~/.emacs.d/plugins/color-theme-6.6.0/")

(setq color-theme-is-global t)

(setq custom-theme-directory (concat user-emacs-directory "themes"))

(dolist
    (path (directory-files custom-theme-directory t "\\w+"))
  (when (file-directory-p path)
    (add-to-list 'custom-theme-load-path path)))

(require 'color-theme)
(color-theme-initialize)

;;(load-theme 'busybee t)
;;(load-theme 'zenburn t)
;;(load-theme 'blackboard t)
;;(load-theme 'wombat t

;; favorite color themes
;; zenburn
;; solarized-dark
;; busybee
;; blackboard
;; wombat


;;(load-theme 'solarized-dark t)
;;(load-theme 'zenburn t)
(load-theme 'ample t)

(provide 'config-colortheme)
