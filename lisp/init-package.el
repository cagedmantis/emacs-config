(require 'cl)
(require 'package)

(add-to-list 'package-archives
			 '("melpa" . "http://melpa.milkbox.net/packages/") t)

(when (< emacs-major-version 24)
  (add-to-list 'package-archives
			   '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; disabled packages
;; yasnippet-bundle
;; flycheck-google-cpplint
;; google-c-style
;; flycheck-google-cpplint
;; google-c-style

(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-ruby
                      starter-kit-eshell

                      exec-path-from-shell
                      go-eldoc
                      go-projectile
                      go-autocomplete
                      go-mode
                      company-go
                      go-errcheck
					  ;;go-gopath
					  
                      color-theme

					  powerline
					  autopair
                      web-mode
                      js2-mode
                      smarty-mode
                      haskell-mode
                      markdown-mode
                      rust-mode
                      tramp
                      yasnippet
                      elpy
                      flymake
                      ac-js2
                      rainbow-delimiters
                      smartparens
                      sql-indent
                      gist
                      magit
                      flycheck
                      flycheck-google-cpplint
                      google-c-style
                      auto-complete
                      auto-complete-c-headers
                      auto-complete-clang
                      cedet
                      company
                      flymake-cursor
                      iedit
                      cedit
                      yasnippet
                      django-snippets
                      neotree
                      php-auto-yasnippets
                      yaml-mode
                      fill-column-indicator
                      diminish
                      projectile
					  ;;projectile-direnv
                      python-mode
                      textmate-to-yas
                      go-complete
                      golint
                      switch-window
                      terraform-mode
                      dockerfile-mode
                      fish-mode
                      rubocop
                      helm
                      aggressive-indent

                      ;; Approved
                      ido
                      flx-ido
                      ido-ubiquitous
                      ido-vertical-mode

                      ;; Themes
                      solarized-theme
                      zenburn-theme
                      ir-black-theme
                      monokai-theme
                      underwater-theme
                      ample-theme
                      busybee-theme
                      danneskjold-theme
					  dracula-theme
					  
                      ;; Experimental
                      ;;auto-reload-mode
                      )
  "A list of packages to ensure are installed at launch.")

;;grabbed from Emacs Prelude
(defun my-packages-installed-p ()
  (loop for p in my-packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (my-packages-installed-p)
  ;; check for new packages (package versions)
  (message "%s" "Emacs is now refreshing its package database...")
  (package-refresh-contents)
  (message "%s" " done.")
  ;; install the missing packages
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(provide 'init-package)
;;; init-package ends here 
