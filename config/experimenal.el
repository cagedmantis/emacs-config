;;; experimental.el --- experimental configuration

;;; Commentary:

;;; Code:

(auto-fill-mode -1)
(remove-hook 'text-mode-hook #'turn-on-auto-fill)

(setq ido-decorations
      '("\n-> " "" "\n   " "\n   ..." "[" "]"
		" [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]"))

(require 'autopair)

(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(setq backup-directory-alist `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))
(setq make-backup-files nil)

(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

(use-package pbcopy
  :ensure t
  :config
  (turn-on-pbcopy))


(provide 'experimental)

;;; experimental.el ends here
