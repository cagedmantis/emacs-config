;; sudo pip install cpplint

;; (if (not (eq (shell-command-to-string "which cpplint") ""))
;;     (setq cpplint t)
;;   (setq cpplint nil))

(defun my:flymake-google-init () 
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command (shell-command-to-string "which cpplint")))
  (flymake-google-cpplint-load)
  )

(add-hook 'c-mode-hook 'my:flymake-google-init)
(add-hook 'c++-mode-hook 'my:flymake-google-init)

; start google-c-style with emacs
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;;(if (not (cpplint)) message "Cpplint isn't installed, please run 'sudo pip install cpplint'")
(provide 'init-flymake-google-cpplint)
