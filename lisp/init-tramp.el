;;; init-tramp.el --- Tramp configuration init  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package tramp
  :ensure nil  ; built-in
  :config
  (require 'tramp nil t)

  (setq tramp-backup-directory-alist backup-directory-alist)
  (setq tramp-backup-directory-alist nil)
  (setq tramp-persistency-file-name "~/.tramp")

  (defun tramp-set-auto-save ()
	(auto-save-mode -1)))

(provide 'init-tramp)

;;; init-tramp.el ends here
