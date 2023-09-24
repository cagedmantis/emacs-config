;;; init-package.el --- init-package copnfiguration

;;; Commentary:

;;; Code:

(require 'package)

;; (add-to-list 'package-archives
;; 			 '("melpa" . "https://melpa.milkbox.net/packages/") t)

(add-to-list 'package-archives
			 '("melpa" . "https://melpa.org/packages/") t)

(add-to-list 'package-archives
			 '("melpa-stable" . "https://stable.melpa.org/packages/") t)

(when (< emacs-major-version 24)
  (add-to-list 'package-archives
			   '("gnu" . "https://elpa.gnu.org/packages/")))

(setq package-user-dir "~/.emacs.d/packages")

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (package '(use-package))
  (unless (package-installed-p package)
    (package-install package)))

(provide 'init-package)
;;; init-package ends here
