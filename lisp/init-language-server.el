;;; init-language-server.el --- init-language-server configuration  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package lsp-mode
  :ensure t
  ;; NOTE: deliberately NOT `:after exec-path-from-shell'.  That package is
  ;; loaded only on macOS GUI/daemon (see darwin.el) and not at all on Linux,
  ;; so gating lsp behind it left lsp completely unconfigured under
  ;; `emacs --daemon' and on Linux.  exec-path-from-shell runs at startup,
  ;; well before any deferred lsp server starts, so the ordering is fine.
  :hook ((c++-mode  ;; clangd
	  c-mode    ;; clangd
	  go-mode   ;; gopls
	  js-mode
	  python-mode
	  rust-mode ;; rust-analyzer
          LaTex-mode
	  ) . lsp-deferred)
  :commands lsp
  :config
  ;; Go-specific format/organize-imports save hooks live in lang-go.el.
  (lsp-register-custom-settings
   '(("gopls.completeUnimported" t t)
     ("gopls.staticcheck" t t)
     ("gopls.usePlaceholders" t t)   ;; tab through function-parameter placeholders
     ("gopls.gofumpt" t t)           ;; stricter gofumpt formatting on save
     ("gopls.semanticTokens" t t)    ;; richer server-driven highlighting
     ;; Extra analyzers (all off by default in gopls)
     ("gopls.analyses.shadow" t t)
     ("gopls.analyses.nilness" t t)
     ("gopls.analyses.unusedparams" t t)
     ("gopls.analyses.unusedwrite" t t)
     ;; Inlay hints (off by default)
     ("gopls.hints.assignVariableTypes" t t)
     ("gopls.hints.compositeLiteralFields" t t)
     ("gopls.hints.compositeLiteralTypes" t t)
     ("gopls.hints.constantValues" t t)
     ("gopls.hints.functionTypeParameters" t t)
     ("gopls.hints.parameterNames" t t)
     ("gopls.hints.rangeVariableTypes" t t)))

  (setq lsp-enable-file-watchers t
        lsp-file-watch-threshold 20000 ;; go has ~12000
        lsp-inlay-hint-enable t          ;; render the gopls inlay hints above
        lsp-semantic-tokens-enable t     ;; render gopls semantic tokens
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

;; Debug Adapter Protocol client (emacs-lsp family, integrates with lsp-mode).
;; Language-specific adapters are loaded from the lang-*.el files (e.g.
;; dap-dlv-go in lang-go.el, which drives Delve/dlv).
(use-package dap-mode
  :ensure t
  :after lsp-mode
  :commands (dap-debug dap-debug-edit-template)
  :config
  ;; Show the debug UI (locals, breakpoints, stack, REPL) automatically and
  ;; enable the on-hover value tooltips while a session is running.
  (dap-auto-configure-mode)
  (dap-tooltip-mode 1))

(use-package which-key
  :ensure t)

(provide 'init-language-server)
;;; init-language-server.el ends here
