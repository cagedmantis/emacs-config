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

(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-ruby starter-kit-eshell yasnippet-bundle tramp solarized-theme zenburn-theme web-mode yasnippet)
  "A list of packages to ensure are installed at launch.")

;; disabled packages
;;  php-mode

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(provide 'config-package)
