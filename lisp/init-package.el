;;; init-package.el --- init-package copnfiguration

;;; Commentary:

;;; Code:

(require 'cl)
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

(defvar my-packages '(
					  use-package
					  use-package-ensure-system-package)
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
