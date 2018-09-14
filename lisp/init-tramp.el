;;; init-tramp.el --- Tramp configuration init

;;; Commentary:

;;; Code:

(use-package tramp
  :ensure t
  :config
  (require 'tramp nil t)

  (setq tramp-backup-directory-alist backup-directory-alist)
  (setq tramp-backup-directory-alist nil)
  (setq tramp-persistency-file-name "~/.tramp")

  (defun tramp-set-auto-save ()
	(auto-save-mode -1)))

(provide 'init-tramp)

;;; init-tramp.el ends here
