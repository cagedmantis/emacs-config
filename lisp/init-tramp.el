;; Tramp: remote file editing
(require 'tramp nil t)

(setq tramp-backup-directory-alist backup-directory-alist)
(setq tramp-backup-directory-alist nil)

(defun tramp-set-auto-save ()
  (auto-save-mode -1))

(provide 'init-tramp)
