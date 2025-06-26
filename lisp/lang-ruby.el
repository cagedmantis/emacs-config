;;; lang-ruby.el --- Ruby development environment configuration

;;; Commentary:
;;
;; This file configures a comprehensive Ruby development environment for Emacs.
;; It provides enhanced syntax highlighting, intelligent code completion,
;; testing support, and Ruby ecosystem integration.
;;
;; Key Features:
;; - Enhanced Ruby mode with advanced syntax support
;; - RSpec testing framework integration
;; - Ruby version management (RVM, rbenv, chruby)
;; - Code quality tools (RuboCop integration)
;; - Interactive Ruby shell (IRB) support
;; - Comprehensive file type associations
;;
;; File Type Support:
;; - Standard Ruby files (.rb)
;; - Ruby on Rails files (Gemfile, Rakefile, etc.)
;; - Configuration files (Capfile, Guardfile, etc.)
;; - Template files (.rabl, .jbuilder)
;; - Deployment files (Vagrant, Docker)
;; - Package files (.gemspec, .podspec)
;;
;; Development Tools:
;; - Enhanced Ruby mode for better syntax handling
;; - RSpec mode for behavior-driven development
;; - Ruby tools for code manipulation
;; - Electric mode for automatic paired characters
;; - Interactive documentation with YARI
;;
;; Version Management:
;; - RVM: Ruby Version Manager support
;; - rbenv: Simple Ruby version management
;; - chruby: Minimal Ruby version switcher
;; - Automatic version detection and switching
;;
;; Code Quality:
;; - RuboCop integration for style enforcement
;; - Real-time linting and style suggestions
;; - Automatic code formatting capabilities
;; - Best practices enforcement
;;
;; Testing Support:
;; - RSpec mode for test-driven development
;; - Test runner integration
;; - Spec file navigation and execution
;; - Behavior-driven development workflow
;;
;; File Associations:
;; - Ruby application files: Gemfile, Rakefile, Capfile
;; - Configuration files: Guardfile, Vagrantfile
;; - Template files: .rabl, .jbuilder, .podspec
;; - Build files: .rake, .thor, .ru (Rack)
;;
;; Dependencies:
;; - enh-ruby-mode: Enhanced Ruby editing
;; - rspec-mode: Testing framework support
;; - ruby-tools: Code manipulation utilities
;; - ruby-electric: Automatic character pairing
;; - rvm, rbenv, chruby: Version managers
;; - rubocop: Code style enforcement
;; - inf-ruby: Interactive Ruby shell
;; - yari: Ruby documentation

;;; Code:

(add-to-list 'auto-mode-alist '("Appraisals\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Berksfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Podfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Puppetfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Thorfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.jbuilder\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.podspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rabl\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.thor\\'" . ruby-mode))

(add-to-list 'completion-ignored-extensions ".rbc")

(use-package enh-ruby-mode
  :ensure t)

(use-package rspec-mode
  :ensure t)

(use-package ruby-tools
  :ensure t)

(use-package ruby-electric
  :ensure t)

(use-package rvm
  :ensure t)

(use-package rbenv
  :ensure t)

(use-package chruby
  :ensure t)

(use-package rubocop
  :ensure t
  :diminish
  :config
  (add-hook 'ruby-mode-hook #'rubocop-mode))

(use-package inf-ruby
  :ensure t)

(use-package yari
  :ensure t)

(provide 'lang-ruby)

;;; lang-ruby.el ends here
