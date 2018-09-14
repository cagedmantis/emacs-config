;;; init-rust.el --- rust configuration

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

  ;; (use-package racer
  ;; 	:ensure company-mode
  ;; 	:config
  ;; 	(add-hook 'racer-mode-hook #'company-mode)
  ;; 	(add-hook 'rust-mode-hook #'racer-mode)
  ;; 	(add-hook 'racer-mode-hook #'eldoc-mode)

  ;; 	(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
  ;; 	(setq company-tooltip-align-annotations t))

  (use-package cargo
	:ensure t))

(provide 'init-rust)

;;; init-rust.el ends here
