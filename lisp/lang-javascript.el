;;; lang-javascript.el --- JavaScript development environment configuration

;;; Commentary:
;;
;; This file configures a comprehensive JavaScript development environment
;; for Emacs. It provides enhanced syntax highlighting, intelligent code
;; completion, refactoring tools, and modern JavaScript/JSX support.
;;
;; Key Features:
;; - Enhanced JavaScript mode with js2-mode
;; - JSX support for React development
;; - JSON file support
;; - Code refactoring with js2-refactor
;; - Intelligent code completion
;; - Automatic code formatting
;;
;; Core Components:
;; - js2-mode: Advanced JavaScript editing mode
;; - js2-refactor: Code refactoring and manipulation tools
;; - ac-js2: Auto-completion for JavaScript
;; - js-format: Code formatting utilities
;;
;; Language Support:
;; - Modern JavaScript (ES6+)
;; - JSX for React components
;; - JSON data files
;; - Strict mode compatibility
;;
;; Configuration:
;; - 2-space indentation (standard for JavaScript)
;; - JSX mode for .js files (React-friendly)
;; - Disabled strict warnings for flexibility
;; - Consistent indentation settings
;;
;; File Associations:
;; - .js files: js2-jsx-mode (supports JSX)
;; - .json files: js2-mode (JSON syntax)
;;
;; Code Quality:
;; - Strict inconsistent return warning disabled
;; - Missing semicolon warning disabled
;; - Configurable for team coding standards
;;
;; Dependencies:
;; - js2-mode: Enhanced JavaScript mode
;; - js2-refactor: Refactoring tools
;; - ac-js2: Auto-completion support
;; - js-format: Code formatting
;; - company: Code completion framework

;;; Code:

(use-package js2-mode
  :ensure t
  :config
  (use-package company
    :ensure t)

  (use-package js2-refactor
	:ensure t
	:config
	(autoload 'js2-mode "js2-mode" nil t)
	(autoload 'js2-jsx-mode "js2-mode" nil t)
	(add-to-list 'auto-mode-alist '("\\.js$" . js2-jsx-mode))
	(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))

	(custom-set-variables '(js2-strict-inconsistent-return-warning nil))
	(custom-set-variables '(js2-strict-missing-semi-warning nil))

	(setq js-indent-level 2)
	(setq js2-indent-level 2)
	(setq js2-basic-offset 2))

  (use-package ac-js2
	:ensure t)

  (use-package js-format
	:ensure t))

(provide 'lang-javascript)

;;; lang-javascript.el ends here
