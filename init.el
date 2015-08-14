;; Emacs config
;; init.el
;; Carlos Amedee

;;set configuration directory
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

;;(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path "~/bin/")
(add-to-list 'load-path (concat dotfiles-dir "/starter_kit"))
(add-to-list 'load-path (concat dotfiles-dir "/configs"))
(add-to-list 'load-path (concat dotfiles-dir "/lisp"))
(add-to-list 'load-path (concat dotfiles-dir "/elpa-to-submit"))
(add-to-list 'load-path (concat dotfiles-dir "/system_type"))
(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))
(setq custom-file (concat dotfiles-dir "custom.el"))
(add-to-list 'load-path "~/.emacs.d/modes/")

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

;; remove these!
(require 'starter-kit-defuns)
(require 'starter-kit-bindings)
(require 'starter-kit-misc)
(require 'starter-kit-registers)
(require 'starter-kit-eshell)
(require 'starter-kit-perl)
(require 'starter-kit-ruby)

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
(require 'init-projectile)
;;(require 'init-python)
;;(require 'init-semantic)
(require 'init-rainbow-delimiters)
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

(message "=== Emacs Init Concluded ===")
