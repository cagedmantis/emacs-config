;;; init-utils.el --- utilities configuration

;;; Commentary:

;;; Code:

;; TODO: revisit enabling expand region
;; (use-package expand-region
;;   :ensure t
;;   :config
;;   ;;(global-set-key (kbd "C-=") 'er/expand-region))
;;   (global-set-key (kbd "@") 'er/expand-region))

(use-package restart-emacs
  :ensure t)

(use-package deadgrep
  :ensure t)

(provide 'init-utils)
;;; init-utils.el ends here
