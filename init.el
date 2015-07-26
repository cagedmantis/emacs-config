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
(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "elpa"))
(setq custom-file (concat dotfiles-dir "custom.el"))
(add-to-list 'load-path "~/.emacs.d/modes/")

;; call the package file
(require 'config-package)

;; general configuration
(require 'config-default)

;; extension hooks
(require 'config-ext)

;; ido configuration
(require 'config-ido)

;; hooks configuration
(require 'config-hook)

;; modes
(require 'go-mode)
(require 'markdown-mode)

;; remove these!
(require 'starter-kit-defuns)
(require 'starter-kit-bindings)
(require 'starter-kit-misc)
(require 'starter-kit-registers)
(require 'starter-kit-eshell)
(require 'starter-kit-perl)
(require 'starter-kit-ruby)

(require 'config-autoinsert)
(require 'config-erc)
(require 'config-yasnippet)
(require 'config-tex)
(require 'config-colortheme)
(require 'xscheme)
(require 'config-columnmarker)
(require 'config-elpy)
(require 'config-jsmode)
;;(require 'config-fill-line)
(require 'config-company)
;;(require 'config-projectile)
(require 'config-magit)
(require 'rainbow-delimiters)
(require 'prelude-ruby)

;; New configs
(require 'init-auto-complete)
(require 'init-auto-complete-clang)
(require 'init-cc)
(require 'init-cedit)
(require 'init-font)
(require 'init-flymake-google-cpplint)
(require 'init-iedit)
;;(require 'init-php)
;;(require 'init-python)
(require 'init-semantic)
(require 'init-sql)
(require 'init-tramp)
(require 'init-volatile-highlights)
(require 'init-whitespace)

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

;;****************************
;; TODO
;;
;; Python custom
;; Haskell custom
;; os specific config
;; client specific config
;; markdown mode
;; css
;; html
;; python
;; c++
;; c
;; django
;; convert items to autoload


;; doxymacs
;; Change the font and size

;;(set-default-font "DejaVu Sans Mono")
;;(set-default-font "Fira")

(setq preferred-font "Fira Mono")
;;(setq preferred-font "Source Code Pro")

;; Does a font exist?
(defun font-existsp (font)
    (if (null (x-list-fonts font))
        nil t))

(if (font-existsp preferred-font)
    (set-default-font preferred-font)
  (set-default-font "DejaVu Sans Mono"))

(set-face-attribute 'default nil :height 120)

(setq tex-dvi-view-command "xdvi")

;; Experimental
;; From: http://whattheemacsd.com/
;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file (expand-file-name ".places" user-emacs-directory))

(message "YO, MTV RAPS! MY CONFIG LOADED!")
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(which-function-mode)

(add-hook 'after-init-hook #'global-flycheck-mode)

;; Elpy
(elpy-enable)
;; Fixing a key binding bug in elpy
(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
;; Fixing another key binding bug in iedit mode
(define-key global-map (kbd "C-c o") 'iedit-mode)

(setq python-check-command "/usr/local/bin/pyflakes")
