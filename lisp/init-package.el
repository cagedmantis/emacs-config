(require 'cl)
(require 'package)

(add-to-list 'package-archives
			 '("melpa" . "https://melpa.milkbox.net/packages/") t)

(when (< emacs-major-version 24)
  (add-to-list 'package-archives
			   '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '( use-package
					   ac-js2
					   aggressive-indent
					   autopair
					   cedit
					   diminish
					   django-snippets
					   elpy
					   fill-column-indicator
					   gist
					   google-c-style
					   helm
					   neotree
					   rubocop
					   smartparens
					   tramp

					   ;; Experimental
					   smooth-scrolling
					   )
  "A list of packages to ensure are installed at launch.")

;; yasnippet-bundle
;; flycheck-google-cpplint
;; google-c-style
;; flycheck-google-cpplint
;; google-c-style
;; dash
;; projectile-direnv

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
