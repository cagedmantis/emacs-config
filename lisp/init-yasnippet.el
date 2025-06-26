;;; init-yasnippet.el --- YASnippet template expansion system configuration

;;; Commentary:
;;
;; This file configures YASnippet (Yet Another Snippet extension), a powerful
;; template system for Emacs. YASnippet allows you to insert code templates
;; (snippets) with placeholder fields that can be quickly filled in, greatly
;; speeding up coding and reducing repetitive typing.
;;
;; Key Features:
;; - Template expansion with TAB key
;; - Placeholder fields with tab navigation
;; - Nested snippets and recursive expansion
;; - Context-aware snippet selection
;; - Support for embedded Elisp code in snippets
;; - Integration with completion systems
;;
;; Snippet Structure:
;; - Template files with placeholder syntax
;; - Tab stops ($1, $2, etc.) for field navigation
;; - Default values and transformations
;; - Conditional logic and dynamic content
;;
;; Usage:
;; - Type snippet trigger and press TAB
;; - Navigate between fields with TAB/S-TAB
;; - Fill in placeholder content
;; - C-c & C-s to insert snippet interactively
;;
;; Language Support:
;; - Comprehensive snippets for major programming languages
;; - Framework-specific templates (React, Django, etc.)
;; - Documentation and comment templates
;; - Custom snippet creation and organization
;;
;; Integration:
;; - Works with all programming modes
;; - Integrates with auto-completion systems
;; - Compatible with LSP and other development tools
;; - Supports snippet sharing and distribution
;;
;; Configuration:
;; - Global mode enabled for all buffers
;; - Large collection of predefined snippets
;; - Expandable through custom snippet directories
;;
;; Dependencies:
;; - yasnippet: Core template expansion engine
;; - yasnippet-snippets: Large collection of predefined snippets

;;; Code:

(use-package yasnippet
  :ensure t
  :config

  (use-package yasnippet-snippets
	:ensure t)

  (yas-global-mode t))

(provide 'init-yasnippet)

;;; init-yasnippet.el ends here
