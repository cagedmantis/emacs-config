;; Change the font and size

;; Does a font exist?
(defun font-existsp (font)
  (if (display-graphic-p)
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
	(if (display-graphic-p)
		(if (font-existsp "Ubuntu Mono")
			(set-frame-font "Ubuntu Mono" nil t)
		  (set-frame-font "Monaco" nil t))
	  (set-frame-font "Source Code Pro"))
  )

;;(set-frame-font "Source Code Pro for Powerline" nil t)

;;(set-face-attribute 'default nil :height 100)


;; experimental
;;(set-frame-font "Fira Code")

(provide 'init-font)
