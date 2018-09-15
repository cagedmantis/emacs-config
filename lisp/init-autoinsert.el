;;; init-autoinsert.el --- Auto insert configuration init

;;; Commentary:

;;; Code:

(use-package autoinsert
  :ensure yasnippet
  :config

  (defun autoinsert-yas-expand()
	"Replace text in yasnippet template."
	(yas-expand-snippet (buffer-string) (point-min) (point-max)))

  (auto-insert-mode)
  (setq auto-insert-directory "~/.emacs.d/templates/") ;;; Or use custom, *NOTE* Trailing slash important
  (setq auto-insert-query nil) ;;; If you don't want to be prompted before insertion

  (define-auto-insert "\\.py$"  [ "insert.py" autoinsert-yas-expand ])
  (define-auto-insert "\\.cpp$" [ "insert.cpp" autoinsert-yas-expand ])
  (define-auto-insert "\\.el$"  [ "insert.el" autoinsert-yas-expand ])
  (define-auto-insert "\\.h$"   [ "insert.h" autoinsert-yas-expand ])
  (define-auto-insert "\\.mk$"  [ "insert.mk" autoinsert-yas-expand ])
  (define-auto-insert "\\.sh$"  [ "insert.sh" autoinsert-yas-expand ]))

(provide 'init-autoinsert)

;;; init-autoinsert.el ends here
