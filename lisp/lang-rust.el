;;; lang-rust.el --- Rust development environment configuration

;;; Commentary:
;;
;; This file configures a comprehensive Rust development environment for Emacs.
;; It provides intelligent code completion, syntax checking, cargo integration,
;; and modern Rust development workflow support.
;;
;; Key Features:
;; - Full Rust language support with rust-mode
;; - Intelligent code completion with Racer
;; - Real-time syntax checking with Flycheck
;; - Cargo build system integration
;; - Automatic code formatting on save
;; - Documentation and signature help
;;
;; Core Components:
;; - rust-mode: Primary Rust editing mode
;; - racer: Rust completion and navigation tool
;; - flycheck-rust: Rust-specific syntax checking
;; - cargo: Build system and package manager integration
;;
;; Development Workflow:
;; - Automatic formatting on save (rustfmt)
;; - Real-time error checking during editing
;; - Code completion with context awareness
;; - Jump to definition and documentation
;; - Cargo command integration
;;
;; Code Completion:
;; - Context-aware suggestions via Racer
;; - Standard library completion
;; - Crate and module completion
;; - Function signature display
;; - Integration with Company mode
;;
;; Error Checking:
;; - Real-time syntax and type checking
;; - Compiler error integration
;; - Cargo check support
;; - Custom error display and navigation
;;
;; Build Integration:
;; - Cargo project management
;; - Build, test, and run commands
;; - Dependency management
;; - Custom cargo configurations
;;
;; Code Formatting:
;; - Automatic rustfmt on save
;; - Consistent code style enforcement
;; - Configurable formatting rules
;; - Integration with Rust style guidelines
;;
;; Setup Requirements:
;; - Rust toolchain (rustc, cargo, rustfmt)
;; - Racer completion tool
;; - Rust source code for standard library completion
;;
;; Key Bindings:
;; - TAB: company-indent-or-complete-common (completion)
;; - Standard Cargo commands via compilation mode
;;
;; Dependencies:
;; - rust-mode: Core Rust editing support
;; - racer: Code completion and navigation
;; - flycheck-rust: Syntax checking
;; - cargo: Build system integration
;; - company: Code completion framework

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

;; (use-package tree-sitter
;;   :ensure t
;;   :config
;;   (require 'tree-sitter-langs)
;;   (global-tree-sitter-mode)
;;   (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(provide 'lang-rust)

;;; lang-rust.el ends here
