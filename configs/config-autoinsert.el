(require 'autoinsert)
(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/templates/autoinsert/") ;;; Or use custom, *NOTE* Trailing slash important
(setq auto-insert-query nil) ;;; If you don't want to be prompted before insertion

(define-auto-insert "\\.py$" "insert.py")
(define-auto-insert "\\.cpp$" "insert.cpp")
(define-auto-insert "\\.el$" "insert.el")
(define-auto-insert "\\.h$" "insert.h")
(define-auto-insert "\\.mk$" "insert.mk")
(define-auto-insert "\\.sh$" "insert.sh")

(provide 'config-autoinsert)

