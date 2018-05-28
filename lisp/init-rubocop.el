;;; init-rubocop.el --- Rubocop configuration init

;;; Commentary:

;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(require 'rubocop)
(add-hook 'ruby-mode-hook #'rubocop-mode)
(provide 'init-rubocop)

;;; init-rubocop.el ends here
