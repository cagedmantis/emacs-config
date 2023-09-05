;;; init-package.el --- init-package copnfiguration

;;; Commentary:

;;; Code:

(require 'package)

(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))
;; (unless (assoc-default "melpa-stable" package-archives)
;;   (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t))
(unless (assoc-default "nongnu" package-archives)
  (add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t))
(when (< emacs-major-version 24)
  (unless (assoc-default "gnu" package-archives)
	(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))))

(setq package-user-dir "~/.emacs.d/packages")

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(provide 'init-package)
;;; init-package ends here
