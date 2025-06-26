;;; lang-python.el --- Python development environment configuration

;;; Commentary:
;;
;; This file configures a comprehensive Python development environment for Emacs.
;; It provides intelligent code completion, syntax checking, code formatting,
;; and development tools integration through Elpy and related packages.
;;
;; Key Features:
;; - Intelligent code completion with Jedi
;; - Real-time syntax checking with Flycheck
;; - Automatic code formatting with autopep8
;; - Virtual environment support with pyenv
;; - Django development support
;; - Interactive Python shell integration
;;
;; Core Components:
;; - Elpy: Comprehensive Python development environment
;; - Pyenv-mode: Python version and virtual environment management
;; - py-autopep8: Automatic PEP8 code formatting
;; - Django-snippets: Django framework templates
;;
;; Code Completion:
;; - Jedi-based intelligent completion
;; - Context-aware suggestions
;; - Module and function documentation
;; - Import completion and management
;;
;; Code Quality:
;; - Flycheck integration for real-time error checking
;; - PEP8 compliance with automatic formatting
;; - Flake8 linting support
;; - Rope refactoring capabilities
;;
;; Development Tools:
;; - IPython shell integration
;; - Virtual environment detection and switching
;; - Django project support
;; - Interactive debugging capabilities
;;
;; Setup Requirements:
;; - pip install elpy rope jedi flake8 autopep8
;; - Python language server for optimal performance
;; - Virtual environment tools (virtualenv, conda)
;;
;; Integration:
;; - Flycheck replaces flymake for better error reporting
;; - Format on save for consistent code style
;; - Django snippet collection for web development
;;
;; Dependencies:
;; - elpy: Python development environment
;; - pyenv-mode: Environment management
;; - py-autopep8: Code formatting
;; - django-snippets: Django templates
;; - flycheck: Syntax checking

;;; Code:

(use-package elpy
  :ensure t
  :config
  (elpy-enable)

  (use-package pyenv-mode
	:ensure t)

  (use-package py-autopep8
	:ensure t
	:config
	(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save))

  (when (require 'flycheck nil t)
  	(setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  	(add-hook 'elpy-mode-hook 'flycheck-mode)))

(use-package django-snippets
  :ensure t)

;; TODO: pip install elpy rope jedi flake8

(provide 'lang-python)

;;; lang-python.el ends here
