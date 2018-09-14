;; Linux specific configs

;; ;; Fonts
;; (if (display-graphic-p)
;; 	(setq preferred-font "Fira Mono"))
;; ;;(setq preferred-font "Source Code Pro")

;; ;; Does a font exist?
;; (defun font-existsp (font)
;;     (if (null (x-list-fonts font))
;;         nil t))

;; (if (font-existsp preferred-font)
;;     (set-default-font preferred-font)
;;   (set-default-font "DejaVu Sans Mono"))

;;(set-default-font "DejaVu Sans Mono")
;;(set-default-font "Source Code Pro")
;;(set-face-attribute 'default nil :height 110)


(provide 'gnu_linux)
