;;; lang-rust.el --- lang-rust configuration

;;; Commentary:

;;; Code:

(use-package rust-mode
  :ensure t
  :config

  (add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
  (setq rust-format-on-save t)

  (use-package flycheck-rust
	:ensure t
	:config
	(add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

  (use-package racer
	:ensure t
	:config
	(add-hook 'rust-mode-hook #'racer-mode)
	(add-hook 'racer-mode-hook #'eldoc-mode)
	(add-hook 'racer-mode-hook #'company-mode)
	(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
	(setq company-tooltip-align-annotations t))

  (use-package cargo
	:ensure t))

(provide 'lang-rust)

;;; lang-rust.el ends here
