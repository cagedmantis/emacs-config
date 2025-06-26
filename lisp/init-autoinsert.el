;;; init-autoinsert.el --- Automatic template insertion configuration

;;; Commentary:
;;
;; This file configures Emacs auto-insert mode to automatically insert
;; predefined templates when creating new files based on file extensions.
;; It integrates with yasnippet to expand template placeholders dynamically.
;;
;; Key Features:
;; - Automatic template insertion for common file types
;; - Integration with yasnippet for dynamic template expansion
;; - Template directory configuration
;; - Support for Python, C++, Elisp, C headers, Makefiles, and shell scripts
;;
;; Templates Directory:
;; - Templates are stored in ~/.emacs.d/templates/
;; - Template files: insert.py, insert.cpp, insert.el, insert.h,
;;   insert.mk, insert.sh
;;
;; Supported File Types:
;; - .py files: Python script templates
;; - .cpp files: C++ source file templates  
;; - .el files: Emacs Lisp file templates
;; - .h files: C/C++ header file templates
;; - .mk files: Makefile templates
;; - .sh files: Shell script templates
;;
;; Dependencies:
;; - yasnippet: Template expansion system

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
