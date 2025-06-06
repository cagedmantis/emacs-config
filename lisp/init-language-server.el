;;; init-language-server.el --- init-language-server configuration

;;; Commentary:

;;; Code:

(use-package lsp-mode
  :ensure t
  :after (exec-path-from-shell)
  :hook ((c++-mode  ;; clangd
	  c-mode    ;; clangd
	  go-mode   ;; gopls
	  js-mode
	  python-mode
	  rust-mode ;; rust-analyzer
	  ) . lsp-deferred)
  :commands lsp
  :config
  (defun lsp-go-install-save-hooks ()
	(add-hook 'before-save-hook #'lsp-format-buffer t t)
	(add-hook 'before-save-hook #'lsp-organize-imports t t))
  (add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

  (lsp-register-custom-settings
   '(("gopls.completeUnimported" t t)
     ("gopls.staticcheck" t t)))

  (setq lsp-enable-file-watchers t
        lsp-file-watch-threshold 20000 ;; go has ~12000
        lsp-enable-which-key-integration t))

;; for some reason this isn't registering above.
(setq lsp-file-watch-threshold 20000)

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode)
  :after (lsp-mode flycheck)
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable t
   		lsp-ui-doc-include-signature t
		lsp-ui-doc-position 'top
		lsp-ui-doc-use-childframe t
		lsp-ui-flycheck-enable t
		lsp-ui-flycheck-list-position 'right
		lsp-ui-flycheck-live-reporting t
		lsp-ui-peek-enable t
		lsp-ui-peek-list-width 60
		lsp-ui-peek-peek-height 25
		;;lsp-ui-sideline-enable nil
		lsp-ui-sideline-ignore-duplicate t))

(use-package lsp-treemacs
  :ensure t
  :config
  (lsp-treemacs-sync-mode 1))

;; (use-package lsp-ivy
;;   :ensure t)

;; (use-package dap-mode
;;   :ensure t)

(use-package which-key
  :ensure t)

(provide 'init-language-server)
;;; init-language-server.el ends here
