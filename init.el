;;; init.el --- Emacs configuration init

;;; Commentary:

;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

;;(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path "~/bin/")
;;(add-to-list 'load-path (concat dotfiles-dir "/starter_kit"))
;;(add-to-list 'load-path (concat dotfiles-dir "/configs"))
(add-to-list 'load-path (concat dotfiles-dir "/config"))
(add-to-list 'load-path (concat dotfiles-dir "/lisp"))
(add-to-list 'load-path (concat dotfiles-dir "/system_type"))
(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))
(setq custom-file (concat dotfiles-dir "custom.el"))
;;(add-to-list 'load-path "~/.emacs.d/modes/")

;; === TODO
;; company-clang
;; company-c-headers

;; === imports ===

(require 'init-package)

(require 'defaults)
(require 'appearance)
(require 'init-font)
(require 'init-ido)
(require 'lang-modes)

(require 'init-colortheme)
(require 'init-columnmarker)
(require 'init-company)
(require 'init-exec-path-from-shell)
(require 'init-flycheck)
(require 'init-go)
(require 'init-iedit)
(require 'init-javascript)
(require 'init-latex)
(require 'init-magit)
(require 'init-org)
(require 'init-powerline)
(require 'init-projectile)
(require 'init-python)
(require 'init-rainbow-delimiters)
(require 'init-saveplace)
(require 'init-sudo-save)
(require 'init-switch-window)
(require 'init-whitespace)
(require 'init-yasnippet)

;; === imports ===

(require 'init-autoinsert)
(require 'init-cc)
(require 'init-erc)
;;(require 'init-cedit)
;;(require 'init-tramp)
;;(require 'init-volatile-highlights)

(cond
 ((eq system-type 'gnu/linux)
  (require 'gnu_linux))
 ((eq system-type 'darwin)
  (require 'darwin))
 )

;system specific configs
(setq system-specific-config (concat dotfiles-dir system-name ".el"))
(if (file-exists-p system-specific-config) (load system-specific-config))

;os specific configs
(setq os-specific-config (concat dotfiles-dir (prin1-to-string system-type) ".el"))
(if (file-exists-p os-specific-config) (load os-specific-config))

;;experimental
;;===================

(auto-fill-mode -1)
(remove-hook 'text-mode-hook #'turn-on-auto-fill)

(global-auto-revert-mode t)

(setq ido-decorations
      '("\n-> " "" "\n   " "\n   ..." "[" "]"
	" [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]"))

;; Use the clipboard, pretty please, so that copy/paste "works"
(setq x-select-enable-clipboard t)

(require 'autopair)

(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)
;;===================

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

;; (use-package spaceline
;;   :ensure t
;;   :config
;;   (require 'spaceline-config)
;;   ;;(spaceline-spacemacs-theme)
;;   (spaceline-emacs-theme)

;;   ;; (use-package spaceline-all-the-icons
;;   ;; 	:ensure t
;;   ;; 	:after spaceline
;;   ;; 	:config (spaceline-all-the-icons-theme))
;;   )

;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

(provide 'init)

;;; init.el ends here
