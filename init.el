;; Emacs config
;; init.el
;; Carlos Amedee

;;set configuration directory

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

;;(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path "~/bin/")
(add-to-list 'load-path (concat dotfiles-dir "/starter_kit"))
(add-to-list 'load-path (concat dotfiles-dir "/configs"))
(add-to-list 'load-path (concat dotfiles-dir "/lisp"))
(add-to-list 'load-path (concat dotfiles-dir "/system_type"))
(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))
(setq custom-file (concat dotfiles-dir "custom.el"))
;;(add-to-list 'load-path "~/.emacs.d/modes/")

;; call the package file
(require 'init-package)

;; general configuration
(require 'config-default)

;; extension hooks
(require 'config-ext)

;; ido configuration
(require 'init-ido)

;; hooks configuration
(require 'config-hook)

;; refactor
(require 'init-go)
(require 'markdown-mode)

;; ~~~~~ Reafactored ~~~~~
(require 'init-exec-path-from-shell)
(require 'init-ace-window)
(require 'init-docean)
(require 'init-dockerfile-mode)
(require 'init-flycheck)
(require 'init-go-complete)
(require 'init-go-eldoc)
(require 'init-go-autocomplete)
(require 'init-go-projectile)
(require 'init-golint)
(require 'init-projectile)
(require 'init-rainbow-delimiters)
(require 'init-switch-window)
(require 'init-yaml-mode)
;; ~~~~~~~~~~~~~~~~~~~~~~~

(require 'init-auto-complete)
(require 'init-autoinsert)
;;(require 'init-auto-complete-clang)
(require 'init-cc)
(require 'init-cedit)
(require 'init-colortheme)
(require 'init-columnmarker)
(require 'init-company)
(require 'init-elpy)
(require 'init-erc)
(require 'init-font)
(require 'init-flymake-google-cpplint)
(require 'init-iedit)
(require 'init-jsmode)
(require 'init-latex)
;;(require 'init-php)
;;(require 'init-python)
;;(require 'init-semantic)
(require 'init-saveplace)
(require 'init-sql)
(require 'init-tramp)
;;(require 'init-volatile-highlights)
(require 'init-whitespace)
(require 'init-which-mode)
(require 'init-yasnippet)

;; review
(require 'init-org)
;;(require 'init-magit)
(require 'init-scheme)
(require 'init-sudo-save)
;;(require 'init-mode-python)
(require 'init-direnv)
(require 'init-powerline)

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

(require 'auto-complete-config)
(ac-config-default)

;; EXPERIMENTAL
(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)

(with-eval-after-load 'go-mode
  (require 'go-autocomplete))

(server-start)

(message "=== Emacs Init Concluded ===")
