;;; init-plantuml.el --- init-plantuml configuration

;;; Commentary:

;;; Code:


(use-package plantuml-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))

  (use-package flycheck-plantuml
	:ensure t
	:config
	(with-eval-after-load 'flycheck
	  (require 'flycheck-plantuml)
	  (flycheck-plantuml-setup))))

(provide 'init-plantuml)

;;; init-plantuml.el ends here
