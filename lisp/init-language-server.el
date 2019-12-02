;;; init-language-server.el --- init-language-server configuration

;;; Commentary:

;;; Code:

(use-package lsp-mode
  :ensure t
  :after (direnv exec-path-from-shell)
  :commands (lsp)
  ;; :hook (prog-mode . (lambda ()
  ;;                      (direnv-update-environment)
  ;;                      (lsp)))
  :config
  (add-hook 'c++-mode-hook #'lsp)
  (add-hook 'go-mode-hook #'lsp)
  (add-hook 'python-mode-hook #'lsp)
  (add-hook 'rust-mode-hook #'lsp)
  (require 'lsp-clients))

;; (use-package lsp-ui
;;   :ensure t
;;   :hook (lsp-mode . lsp-ui-mode)
;;   :after (lsp-mode flycheck)
;;   :commands lsp-ui-mode
;;   :config
;;   (setq lsp-ui-doc-enable t
;; 		lsp-ui-doc-include-signature t
;; 		lsp-ui-doc-position 'top
;; 		lsp-ui-doc-use-childframe t
;; 		lsp-ui-flycheck-enable t
;; 		lsp-ui-flycheck-list-position 'right
;; 		lsp-ui-flycheck-live-reporting t
;; 		lsp-ui-peek-enable t
;; 		lsp-ui-peek-list-width 60
;; 		lsp-ui-peek-peek-height 25
;; 		;;lsp-ui-sideline-enable nil
;; 		lsp-ui-sideline-ignore-duplicate t))

(use-package company-lsp
  :ensure t
  :after (company lsp-mode)
  :commands company-lsp
  :config
  (setq company-lsp-cache-candidates nil
		;;company-lsp-cache-candidates 'auto
		company-transformers nil
		company-lsp-async t
		company-lsp-enable-recompletion t)

  :init
  (push 'company-lsp company-backends))

;; https://github.com/emacs-lsp/lsp-mode
;; pip install ‘python-language-server[all]’
;; gem install solargraph
;; rls
;; npm i -g bash-language-server
;; ccls, clangd, cquery

(provide 'init-language-server)
;;; init-language-server.el ends here
