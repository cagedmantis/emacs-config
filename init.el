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
(add-to-list 'load-path (concat dotfiles-dir "/config"))
(add-to-list 'load-path (concat dotfiles-dir "/lisp"))
(add-to-list 'load-path (concat dotfiles-dir "/system_type"))
(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))
(setq custom-file (concat dotfiles-dir "custom.el"))

;; === TODO
;; company-clang
;; company-c-headers

;; === imports ===

(require 'init-package)

(require 'defaults)
(require 'appearance)
(require 'init-font)
;;(require 'init-ido)  Testing out ivy instead of ido
(require 'init-ivy)
(require 'init-colortheme)

(require 'lang-modes)
(require 'init-powerline)

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

;;(require 'experimental)

;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

(provide 'init)

;;; init.el ends here
