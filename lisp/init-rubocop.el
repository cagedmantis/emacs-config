;;; init-rubocop.el --- Rubocop configuration init

;;; Commentary:

;;; Code:

(require 'rubocop)
(add-hook 'ruby-mode-hook #'rubocop-mode)
(provide 'init-rubocop)

;;; init-rubocop.el ends here
