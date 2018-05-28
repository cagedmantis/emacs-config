;;; init-tramp.el --- Tramp configuration init

;;; Commentary:

;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; Tramp: remote file editing
(require 'tramp nil t)

(setq tramp-backup-directory-alist backup-directory-alist)
(setq tramp-backup-directory-alist nil)
(setq tramp-persistency-file-name "~/.tramp")

(defun tramp-set-auto-save ()
  (auto-save-mode -1))

(provide 'init-tramp)

;;; init-tramp.el ends here
