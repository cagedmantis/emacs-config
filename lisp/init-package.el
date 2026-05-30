;;; init-package.el --- init-package copnfiguration  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(require 'package)

(setq package-user-dir (concat user-emacs-directory "packages"))

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

;; package.el recompiles the package you upgrade, but not its dependents, so a
;; dependent's `.elc' can go stale against a newer dependency.  A concrete case:
;; `compat-call' resolves the compat shim vs. built-in at byte-compile time, so
;; upgrading `compat' after `marginalia' was compiled froze a call to the 1-arg
;; built-in `seconds-to-string', breaking file annotations in the minibuffer.
;; Recompiling everything after an upgrade rebuilds against the loaded versions.
(dolist (cmd '(package-upgrade package-upgrade-all))
  (advice-add cmd :after (lambda (&rest _) (package-recompile-all))))

(provide 'init-package)
;;; init-package ends here
