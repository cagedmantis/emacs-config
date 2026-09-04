;;; early-init.el --- Setup that must precede package activation  -*- lexical-binding: t; -*-

;;; Commentary:

;; Loaded by Emacs 27+ before `package-activate-all' and before init.el.
;; Only things that must be in place *before* packages are activated belong
;; here; everything else goes in init.el / lisp/.

;;; Code:

;; `package-activate-all' runs before init.el, using the *default*
;; `package-user-dir' (~/.emacs.d/elpa).  Any leftover elpa/ tree is therefore
;; pushed onto `load-path' and recorded in `package-activated-list' before
;; init-package.el gets a chance to point `package-user-dir' at packages/ --
;; and because activation is skipped for an already-activated package, the
;; stale copies win for the rest of the session.  That silently downgraded
;; every shadowed package and made the obsolete `cl' library load ("Package cl
;; is deprecated") via an ancient smartparens.
;;
;; Setting `package-user-dir' here, before activation, makes the packages/
;; tree the only one that is ever activated.  Keep this in sync with
;; `lisp/init-package.el', which sets the same value for the rest of startup.
(setq package-user-dir (expand-file-name "packages" user-emacs-directory))

(provide 'early-init)
;;; early-init.el ends here
