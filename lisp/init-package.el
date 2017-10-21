(require 'cl)
(require 'package)

(add-to-list 'package-archives
			 '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; (when (< emacs-major-version 24)
;;   (add-to-list 'package-archives
;; 			   '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; disabled packages
;; yasnippet-bundle
;; flycheck-google-cpplint
;; google-c-style
;; flycheck-google-cpplint
;; google-c-style
;; s
;; dash
;; projectile-direnv

(defvar my-packages '( use-package 
					   go-gopath
					   projectile
					   color-theme
					   ;;pbcopy
					   powerline
					   autopair
					   smarty-mode
					   tramp
					   yasnippet
					   elpy
					   ac-js2
					   rainbow-delimiters
					   smartparens
					   sql-indent
					   gist
					   magit
					   ;;flycheck-google-cpplint
					   google-c-style
					   auto-complete
					   auto-complete-c-headers
					   auto-complete-clang
					   cedet
					   iedit
					   cedit
					   yasnippet
					   django-snippets
					   neotree
					   php-auto-yasnippets

					   fill-column-indicator
					   diminish
					   textmate-to-yas
					   switch-window
					   rubocop
					   helm
					   aggressive-indent
					   column-marker

					   ;; Experimental
					   smooth-scrolling 
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
