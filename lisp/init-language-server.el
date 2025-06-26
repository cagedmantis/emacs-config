;;; init-language-server.el --- Language Server Protocol (LSP) configuration

;;; Commentary:
;;
;; This file configures the Language Server Protocol (LSP) integration for Emacs.
;; LSP provides advanced IDE-like features including intelligent code completion,
;; real-time error checking, symbol navigation, and refactoring capabilities
;; across multiple programming languages.
;;
;; Key Features:
;; - Multi-language support (C/C++, Go, JavaScript, Python, Rust)
;; - Real-time syntax checking and error reporting
;; - Intelligent code completion with context awareness
;; - Symbol navigation (find definition, references, implementations)
;; - Code formatting and import organization on save
;; - Hover documentation and signature help
;; - Workspace symbol search and project-wide operations
;;
;; Language Server Support:
;; - C/C++: clangd (requires clang installation)
;; - Go: gopls (Go language server)
;; - JavaScript: Various JS language servers
;; - Python: Python language servers (pylsp, pyright)
;; - Rust: rust-analyzer (Rust language server)
;;
;; UI Components:
;; - lsp-ui: Enhanced UI with sideline info, documentation popups
;; - lsp-treemacs: Tree view integration for symbols and errors
;; - Flycheck integration for error display
;;
;; Automatic Actions:
;; - Format buffer on save
;; - Organize imports on save
;; - File watching for project changes (up to 20,000 files)
;;
;; Dependencies:
;; - lsp-mode: Core LSP client
;; - lsp-ui: Enhanced UI components
;; - lsp-treemacs: Treemacs integration
;; - flycheck: Syntax checking integration
;; - which-key: Help system integration

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
  (defun lsp-install-save-hooks ()
	"Install LSP before-save hooks for formatting and organizing imports."
	(add-hook 'before-save-hook #'lsp-format-buffer t t)
	(add-hook 'before-save-hook #'lsp-organize-imports t t))

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

;; which-key configuration moved to init-defaults.el

(provide 'init-language-server)
;;; init-language-server.el ends here
