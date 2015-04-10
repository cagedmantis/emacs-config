;;
;;
;;

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

(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-ruby starter-kit-eshell tramp solarized-theme zenburn-theme web-mode yasnippet ir-black-theme underwater-theme powerline elpy ample-theme flymake js2-mode ac-js2 auto-complete-clang cedet auto-complete auto-complete-c-headers volatile-highlights diminish)

  "A list of packages to ensure are installed at launch.")

;; disabled packages
;;  php-mode
;;  yasnippet-bundle
;; flycheck
;; flycheck-google-cpplint
;; google-c-style 

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(provide 'config-package)
