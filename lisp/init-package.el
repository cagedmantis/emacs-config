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

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(dolist (package '(use-package))
  (unless (package-installed-p package)
    (package-install package)))

(provide 'init-package)
;;; init-package ends here
