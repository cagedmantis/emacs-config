;;; init.el --- Emacs configuration init

;; Emacs config
;; init.el
;; Carlos Amedee

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

;; === imports ===

(auto-fill-mode -1)
(remove-hook 'text-mode-hook #'turn-on-auto-fill)

;; call the package file


;; general configuration
;;(require 'config-default)

(require 'defaults)
(require 'appearance)
(require 'init-ido) ;;use-packages
(require 'lang-modes)

;; extension hooks
;;(require 'config-ext)

;; hooks configuration
;;(require 'config-hook)

;; ~~~~~ use-package ~~~~~

(require 'init-flycheck)
(require 'init-go)
(require 'init-javascript)
(require 'init-python)
(require 'init-colortheme)
(require 'init-company)
(require 'init-exec-path-from-shell)
(require 'init-magit)
(require 'init-powerline)

;; ~~~~~ Reafactored ~~~~~

(require 'init-ace-window)
(require 'init-docean)
(require 'init-dockerfile-mode)
(require 'init-projectile)
(require 'init-rainbow-delimiters)
(require 'init-switch-window)
(require 'init-yaml-mode)

;; ~~~~~~~~~~~~~~~~~~~~~~~

(require 'init-autoinsert)
(require 'init-cc)
(require 'init-cedit)
(require 'init-columnmarker)
(require 'init-erc)
(require 'init-font)
;;(require 'init-flymake-google-cpplint)
(require 'init-iedit)
(require 'init-jsmode)
(require 'init-latex)
;;(require 'init-semantic)
(require 'init-saveplace)
(require 'init-sql)
;;(require 'init-tramp)
;;(require 'init-volatile-highlights)
(require 'init-whitespace)
;;(require 'init-which-mode)
(require 'init-yasnippet)

;; review
;;(require 'init-org)
(require 'init-scheme)
(require 'init-sudo-save)


;; --------------------------------------
;; Do you even work?
;; --------------------------------------
(require 'init-direnv)

;; --------------------------------------

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

;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

(provide 'init)

;;; init.el ends here
