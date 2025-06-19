;;; init-package.el --- Package management configuration

;;; Commentary:
;;
;; This file sets up Emacs package management system with multiple package archives.
;; It configures package repositories, initializes the package system, and ensures
;; use-package is available for declarative package configuration.
;;
;; Package Archives:
;; - MELPA: Main community package repository (bleeding edge)
;; - MELPA Stable: Stable versions of MELPA packages (disabled)
;; - NonGNU ELPA: Additional GNU-compatible packages
;; - GNU ELPA: Official GNU packages (for older Emacs versions)
;;
;; Features:
;; - Custom package directory (packages/ instead of elpa/)
;; - Automatic package archive refresh on first run
;; - Automatic use-package installation
;; - Support for Emacs versions < 24

;;; Code:

(require 'package)

;; Use custom directory for packages instead of default elpa/
(setq package-user-dir (concat user-emacs-directory "packages"))

;; Add package archives (repositories)
(unless (assoc-default "melpa" package-archives)
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t))

;; MELPA Stable is disabled - uncomment if you prefer stable versions
;; (unless (assoc-default "melpa-stable" package-archives)
;;   (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t))

;; NonGNU ELPA for additional GNU-compatible packages
(unless (assoc-default "nongnu" package-archives)
  (add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t))

;; GNU ELPA for older Emacs versions (< 24) that don't have it by default
(when (< emacs-major-version 24)
  (unless (assoc-default "gnu" package-archives)
	(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/"))))

;; Initialize the package system
(package-initialize)

;; Refresh package archive contents if not already done
(when (not package-archive-contents)
  (package-refresh-contents))

;; Ensure use-package is installed for declarative package configuration
(dolist (package '(use-package))
  (unless (package-installed-p package)
    (package-install package)))

(provide 'init-package)
;;; init-package ends here
