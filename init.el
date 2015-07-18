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
(require 'config-tramp)
(require 'xscheme)
(require 'config-columnmarker)
(require 'config-mode-php)
(require 'config-elpy)
(require 'config-jsmode)
(require 'config-fill-line)
(require 'config-company)
;;(require 'config-projectile)
(require 'config-magit)

;; Enable system-type specific behaviour
;; (if (eq system-type 'gnu/linux)
;;     (require 'gnu_linux))
;; (if (eq system-type 'darwin)
;;     (require 'darwin))

(cond
 ((eq system-type 'gnu/linux)
  (require 'gnu_linux))
 ((eq system-type 'darwin)
  (require 'darwin))
 )

(require 'rainbow-delimiters)

;; Experimental
;;(require 'config-gnus)

;; Refactor
(require 'init-sql)
(require 'init-php)
(require 'init-font)
(require 'init-auto-complete)
(require 'init-iedit)
(require 'init-flymake-google-cpplint)
(require 'init-cedit)


;system specific configs
(setq system-specific-config (concat dotfiles-dir system-name ".el"))
(if (file-exists-p system-specific-config) (load system-specific-config))

;os specific configs
(setq os-specific-config (concat dotfiles-dir (prin1-to-string system-type) ".el"))
(if (file-exists-p os-specific-config) (load os-specific-config))

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

;;utf-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

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

;; (require 'powerline)
;; (powerline-center-evil-theme)

;;misc
(message system-name)
(message (prin1-to-string system-type))

(getenv "PATH")
(setenv "PATH"
        (concat
         "/usr/texbin" ":"
         (getenv "PATH")))

(setq default-directory "~/")

(require 'cc-mode)

(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode t)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

;; (require 'autopair)
;; (autopair-global-mode 1)
;; (setq autopair-autowrap t)

(require 'auto-complete-clang)
(define-key c++-mode-map (kbd "C-S-<return>") 'ac-complete-clang)
;; replace C-S-<return> with a key binding that you want

(require 'auto-complete)
(ac-config-default)
(yas-global-mode 1)

; turn on Semantic
(semantic-mode 1)
; let's define a function which adds semantic as a suggestion backend to auto complete
; and hook this function to c-mode-common-hook
(defun my:add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)
; turn on ede mode
(global-ede-mode 1)
; create a project for our program.

; turn on automatic reparsing of open buffers in semantic
(global-semantic-idle-scheduler-mode 1)

(setq default-major-mode 'c-mode)
(setq inhibit-default-init t)

(defun my-c-mode-common-hook ()
        (setq-default c-style-variables-are-local-p t)
        (setq-default c-basic-offset 8)
		(setq-default indent-tabs-mode t)
		(setq-default tab-width 8)
		(setq c-basic-offset 8)
		(setq c-basic-indent 8)
		)
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(add-hook 'c++-mode-common-hook 'my-c-mode-common-hook)

(setq inhibit-default-init t)
(setq default-major-mode 'c-mode)

(add-to-list 'auto-mode-alist '("\\.php$" . c++-mode))

(my-c-mode-common-hook)

;; highlight the current line
(global-hl-line-mode +1)

(require 'volatile-highlights)
(volatile-highlights-mode t)
(diminish 'volatile-highlights-mode)

(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face tabs empty trailing lines-tail))

;; Experimental
(setq-default show-trailing-whitespace t)
(setq-default indicate-empty-lines t)
(global-whitespace-mode t)
