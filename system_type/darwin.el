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
;;(setq preferred-font "ANONYMOUS PRO")

;; Does a font exist?
(defun font-existsp (font)
  (if (window-system)
	  (if (null (x-list-fonts font))
		  nil t)
	)
  )

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

(setq default-directory "~/")

(defun swap-meta-and-super ()
  "Swap the mapping of meta and super. Very useful for people using their Mac
with a Windows external keyboard from time to time."
  (interactive)
  (if (eq mac-command-modifier 'super)
      (progn
        (setq mac-command-modifier 'meta)
        (setq mac-option-modifier 'super)
        (message "Command is now bound to META and Option is bound to SUPER."))
    (progn
      (setq mac-command-modifier 'super)
      (setq mac-option-modifier 'meta)
      (message "Command is now bound to SUPER and Option is bound to META."))))

(global-set-key (kbd "C-c w") 'swap-meta-and-super)

;;utf-8
(prefer-coding-system 'utf-8)
(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

;;utf-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)


(provide 'darwin)
