;; Change the font and size

;; Does a font exist?
(defun font-existsp (font)
  (if (window-system)
	  (if (null (x-list-fonts font))
		  nil t))
  )

;; (if (font-existsp preferred-font)
;;     (set-default-font preferred-font)
;;   (set-default-font "DejaVu Sans Mono"))

(defvar preferred-fonts '("Fira Mono"
                          "Source Code Pro"
                          "DejaVu Sans Mono"
						  "Monaco"
						  "Ubuntu Mono"
						  "Hack"))

;; Set font for linux and misc.
(if (eq system-type 'gnu/linux)
	(if (window-system)
		(if (font-existsp "Ubuntu Mono")
			(set-default-font "Ubuntu Mono")
		  (set-default-font "Monaco"))
	  (set-default-font  "Source Code Pro"))
  )

;;(set-face-attribute 'default nil :height 120)

(provide 'init-font)
