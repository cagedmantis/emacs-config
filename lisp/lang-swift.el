;;; lang-swift.el --- lang-swift configuration

;;; Commentary:

;;; Code:

(use-package swift-mode
  :ensure t)

(use-package flycheck-swift
  :ensure t
  :config
  '(eval-after-load 'flycheck '(flycheck-swift-setup)))

(provide 'lang-swift)
;;; lang-swift.el ends here
