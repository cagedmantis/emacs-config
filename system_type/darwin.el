;; OS X specific configs

;convert fn key on macbook pro to ctl key
(setq ns-function-modifier 'control)
(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)

;; Fonts
;;(set-default-font "DejaVu Sans Mono")
;;(set-default-font "Fira")

;;(setq preferred-font "Fira Mono")
(setq preferred-font "Source Code Pro")

;; Does a font exist?
(defun font-existsp (font)
    (if (null (x-list-fonts font))
        nil t))

(if (font-existsp preferred-font)
    (set-default-font preferred-font)
  (set-default-font "DejaVu Sans Mono"))

(set-face-attribute 'default nil :height 130)


;; Latex hacks
(getenv "PATH")
 (setenv "PATH"
(concat
 "/usr/texbin" ":"

(getenv "PATH")))

(message "IT WORKED!!!")


(provide 'darwin)
