;; Emacs config
;; init.el
;; Carlos Amedee

;;set configuration directory
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(add-to-list 'load-path dotfiles-dir)
(add-to-list 'load-path "~/bin/")
(add-to-list 'load-path (concat dotfiles-dir "/configs"))
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
(require 'config-tramp)
(require 'xscheme)
(require 'config-columnmarker)
(require 'config-mode-php)
(require 'config-elpy)

;system specific configs
(setq system-specific-config (concat dotfiles-dir system-name ".el"))
(if (file-exists-p system-specific-config) (load system-specific-config))

;os specific configs
(setq os-specific-config (concat dotfiles-dir (prin1-to-string system-type) ".el"))
(if (file-exists-p os-specific-config) (load os-specific-config))

;convert fn key on macbook pro to ctl key
(setq ns-function-modifier 'control)

(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)

(defun swap-meta-and-super ()
  "Swap the mapping of meta and super. Very useful for people using their Mac
with a Windows external keyboard from time to time."
  (interactive)
  (if (eq mac-command-modifier 'super)
      (progn
        (setq mac-command-modifier 'meta)
        (setq mac-option-modifier 'super)
        (message "Command is now bound to META and Option is bound to SUPER."))
    (progn
      (setq mac-command-modifier 'super)
      (setq mac-option-modifier 'meta)
      (message "Command is now bound to SUPER and Option is bound to META."))))

(global-set-key (kbd "C-c w") 'swap-meta-and-super)

;;utf-8
(prefer-coding-system 'utf-8)
(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

;;misc
(message system-name)
(message (prin1-to-string system-type))

;;utf-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(shell)

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
(set-default-font "DejaVu Sans Mono")
(set-face-attribute 'default nil :height 121)

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


;; Experimental
(which-function-mode)

;; Experimental
(add-hook 'after-init-hook #'global-flycheck-mode)
;; (require 'powerline)
;; (powerline-center-evil-theme)

(getenv "PATH")
 (setenv "PATH"
(concat
 "/usr/texbin" ":"

(getenv "PATH")))

