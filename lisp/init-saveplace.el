;;; init-saveplace.el --- Save place configuration init

;;; Commentary:

;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(when (>= emacs-major-version 25)
  (save-place-mode 1))

(when (< emacs-major-version 25)
  (require 'saveplace)
  (setq-default save-place t))

(setq save-place-file (expand-file-name ".places" user-emacs-directory))

(provide 'init-saveplace)

;;; init-saveplace.el ends here
