;;; init-language-server.el --- init-language-server configuration

;;; Commentary:

;;; Code:

(use-package lsp-mode
  :ensure t
  :commands lsp)
  ;; :init
  ;; (setq ...))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :init
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package company-lsp
  :ensure t
  :after company
  :commands company-lsp
  :init
  (push 'company-lsp company-backends))

(use-package dap-mode
  :ensure t)

(provide 'init-language-server)
;;; init-language-server.el ends here
