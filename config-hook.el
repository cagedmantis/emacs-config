;;; (>>FILE<<) --- 

;; Copyright (C) Carlos Amedee
;;
;; Author: Carlos Amedee <carlos.amedee@gmail.com>
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet


(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook 'turn-on-flyspell)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;(add-hook 'emacs-lisp-mode-hook 'auto-make-header)

(provide 'config-hook)
