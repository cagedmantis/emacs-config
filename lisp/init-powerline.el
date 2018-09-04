;; (use-package powerline
;;   :ensure t
;;   :config
;;   (require 'powerline)
;;   (powerline-default-theme))

;; (use-package smart-mode-line-powerline-theme
;;   :ensure t
;;   :config
;;   (sml/setup))

(use-package smart-mode-line
  :ensure t
  :config
  (setq sml/theme 'dark)
  (setq sml/no-confirm-load-theme t)
  (sml/setup))

;; (use-package smart-mode-line
;;   :ensure t
;;   :config
;;   (progn
;;     (tool-bar-mode -1)
;;     (setq sml/theme 'respectful)
;;     (setq sml/name-width 40)
;;     (setq sml/mode-width 'full)
;;     (set-face-attribute 'mode-line nil
;; 			:box nil)
;;     (add-to-list 'sml/replacer-regexp-list '("^~/src/" ":src:") t)))


(provide 'init-powerline)
