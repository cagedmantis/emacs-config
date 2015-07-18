(require 'cl)
(require 'package)

(add-to-list 'package-archives
   '("melpa" . "http://melpa.milkbox.net/packages/") t)

(when (< emacs-major-version 24)
  (add-to-list 'package-archives
    '("gnu" . "http://elpa.gnu.org/packages/")))

;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))


;; disabled packages
;; php-mode
;; yasnippet-bundle
;; flycheck
;; flycheck-google-cpplint
;; google-c-style
;; powerline

(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-ruby
                      starter-kit-eshell
                      solarized-theme
                      zenburn-theme
                      ir-black-theme
                      underwater-theme
                      ample-theme
                      web-mode
                      js2-mode
                      smarty-mode
                      haskell-mode
                      markdown-mode
                      go-mode
                      rust-mode
                      tramp
                      yasnippet
                      powerline
                      elpy
                      flymake
                      ac-js2
                      rainbow-delimiters
                      smartparens
                      sql-indent
                      gist
                      magit
                      ;; php-mode
                      ;; flycheck
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
                      go-snippets
                      php-auto-yasnippets
                      fill-column-indicator
                      diminish
                      textmate-to-yas)
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

(provide 'config-package)
