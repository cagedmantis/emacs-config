;;; init-utils.el --- utilities configuration

;;; Commentary:

;;; Code:

(use-package expand-region
  :ensure t
  :config
  ;;(global-set-key (kbd "C-=") 'er/expand-region))
  (global-set-key (kbd "@") 'er/expand-region))

(use-package restart-emacs
  :ensure t)

(provide 'init-utils)
;;; init-utils.el ends here
