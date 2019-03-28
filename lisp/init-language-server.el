;;; init-language-server.el --- init-language-server configuration

;;; Commentary:

;;; Code:

(use-package lsp-mode
  :ensure t
  :after (direnv exec-path-from-shell)
  :commands (lsp)
  :hook (prog-mode . (lambda ()
                       (direnv-update-environment)
                       (lsp)))
  :config
  (require 'lsp-clients))

;; (use-package lsp-mode
;;   :ensure t
;;   :commands lsp)
;;   ;; :init
;;   ;; (setq ...))

;; (use-package lsp-ui
;;   :ensure t
;;   :after lsp-mode
;;   :config
;;   (setq lsp-ui-doc-header t
;;         lsp-ui-doc-include-signature t
;;         lsp-ui-doc-max-width 80
;;         lsp-ui-doc-max-height 20
;;         lsp-ui-doc-use-childframe nil))

(use-package lsp-ui
  :ensure t
  :hook (lsp-mode . lsp-ui-mode)
  :after lsp-mode
  :config
  (setq lsp-ui-sideline-ignore-duplicate t))
  ;; :config
  ;; (setq lsp-ui-doc-header t
  ;;       lsp-ui-doc-include-signature t
  ;;       lsp-ui-doc-max-width 80
  ;;       lsp-ui-doc-max-height 20
  ;;       lsp-ui-doc-use-childframe nil))


;; (use-package lsp-ui
;;   :ensure t
;;   :commands lsp-ui-mode
;;   :init
;;   (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package company-lsp
  :ensure t
  :after (company lsp-mode)
  :commands company-lsp
  :config
  (setq company-lsp-cache-candidates 'auto
		company-lsp-async t
		company-lsp-enable-recompletion t)

  :init
  (push 'company-lsp company-backends))

(use-package dap-mode
  :ensure t)

;; https://github.com/emacs-lsp/lsp-mode
;; pip install ‘python-language-server[all]’
;; gem install solargraph
;; rls
;; npm i -g bash-language-server
;; ccls, clangd, cquery

(provide 'init-language-server)
;;; init-language-server.el ends here
