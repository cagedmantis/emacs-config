;;; lang-ruby.el --- lang-ruby configuration

;;; Commentary:

;;; Code:

(add-to-list 'auto-mode-alist '("\\.rake\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.thor\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rabl\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Thorfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.jbuilder\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Podfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.podspec\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Puppetfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Berksfile\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("Appraisals\\'" . ruby-mode))

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

(use-package chef-mode
  :ensure t)

(use-package inf-ruby
  :ensure t)

(use-package yari
  :ensure t)

(provide 'lang-ruby)

;;; lang-ruby.el ends here
