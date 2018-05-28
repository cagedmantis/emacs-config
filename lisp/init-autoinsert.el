;;; init.el --- Auto insert configuration init

;;; Commentary:

;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(use-package autoinsert
  :ensure yasnippet
  :config

  (defun autoinsert-yas-expand()
	"Replace text in yasnippet template."
	(yas-expand-snippet (buffer-string) (point-min) (point-max)))

  (auto-insert-mode)
  (setq auto-insert-directory "~/.emacs.d/templates/autoinsert/") ;;; Or use custom, *NOTE* Trailing slash important
  (setq auto-insert-query nil) ;;; If you don't want to be prompted before insertion

  (define-auto-insert "\\.py$"  [ "insert.py" autoinsert-yas-expand ])
  (define-auto-insert "\\.cpp$" [ "insert.cpp" autoinsert-yas-expand ])
  (define-auto-insert "\\.el$"  [ "insert.el" autoinsert-yas-expand ])
  (define-auto-insert "\\.h$"   [ "insert.h" autoinsert-yas-expand ])
  (define-auto-insert "\\.mk$"  [ "insert.mk" autoinsert-yas-expand ])
  (define-auto-insert "\\.sh$"  [ "insert.sh" autoinsert-yas-expand ]))

(provide 'init-autoinsert)

;;; init-autoinsert.el ends here
