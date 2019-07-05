;;; appearance.el --- appearance configuration

;;; Commentary:

;;; Code:
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))  ; Disable the scrollbar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))      ; Disable the toolbar
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))      ; Disable the menubar

(setq inhibit-startup-message t)               ; No message at startup
(column-number-mode t)                         ; Show column number in mode-line
(line-number-mode 1)                           ; show line number the cursor is on, in status bar (the mode line)
(global-font-lock-mode t)		               ; fonts are automatically highlighted
(size-indication-mode t)
(show-paren-mode 1)                            ; turn on paren match highlighting
(global-visual-line-mode 1)                    ; Soft wrap lines
;;(setq-default cursor-type 'hollow)

;; -- line numbers --
;; ------------------
(when (version< emacs-version "26.0.50")
  (progn
	(global-linum-mode 1)
	(setq linum-format " %d ")
	(setq linum-format (if (not window-system) " %4d " " %4d "))

	(defun linum-on ()
	  (unless (or (minibufferp) (member major-mode linum-disabled-modes))
		(linum-mode 1)))

	;;disable line mode for listed modes
	(setq linum-disabled-modes-list
		  '(ansi-term
			compilation-mode
			eshell-mode
			fundamental-mode
			help-mode
			magit-status-mode
			mu4e-headers-mode
			mu4e-main-mode
			mu4e-view-mode
			nrepl-mode
			shell-mode
			slime-repl-mode
			term-mode
			term-mode
			wl-summary-mode))
	(defun linum-on ()
	  (unless (or (minibufferp) (member major-mode linum-disabled-modes-list))
		(linum-mode 1)))))

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode t)
  (setq display-line-numbers " %4d "))

(when window-system
  (tooltip-mode -1)
  (blink-cursor-mode -1)
  (mouse-wheel-mode t)
  (progn (fringe-mode 5)
         (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
         (add-to-list 'default-frame-alist '(ns-appearance . dark))
           ;;;(add-to-list 'default-frame-alist '(ns-appearance . light))
         (setq frame-title-format nil)))

(set-default 'indicate-empty-lines t)
(set-default 'imenu-auto-rescan t)

(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq echo-keystrokes 0.1)
(setq font-lock-maximum-decoration t)
(setq transient-mark-mode t)
(setq mouse-yank-at-point t)
(setq require-final-newline t)
(setq truncate-partial-width-windows nil)
(setq uniquify-buffer-name-style 'forward)
(setq ffap-machine-p-known 'reject)
(setq xterm-mouse-mode t)
(ansi-color-for-comint-mode-on)

;; Default to unified diffs
(setq diff-switches "-u -w"
      magit-diff-options "-w")

;;store all autosave files
(setq auto-save-file-name-transforms
      `((".*" ,"~/.emacs.d/auto-save-list" t)))

;; Don't defer screen updates when performing operations
(setq redisplay-dont-pause t)

;; Highlight the line number of the current line.
(use-package hlinum
  :ensure t
  :config
  (hlinum-activate))

;; Modeline - hai2nan
(if (version< emacs-version "25.3")
	(message "--> minions isn't supported in this version of Emacs")
  (when window-system
	(use-package moody
	  :ensure t
	  :config
	  (setq x-underline-at-descent-line t)
	  (setq moody-mode-line-height 24)
	  (setq moody-slant-function #'moody-slant-apple-rgb)
	  (moody-replace-mode-line-buffer-identification)
	  (moody-replace-vc-mode))))

(add-hook 'prog-mode-hook (lambda ()
                            (interactive)
                            (setq show-trailing-whitespace 1)))

;; Reduce scroll lag
;; https://emacs.stackexchange.com/questions/28736/emacs-pointcursor-movement-lag/28746
(setq auto-window-vscroll nil)

(use-package whitespace
  :ensure t
  :config
  (setq whitespace-line-column 80) ;; limit line length
  (setq whitespace-style '(face tabs empty trailing lines-tail))
  (add-hook 'before-save-hook 'delete-trailing-whitespace))

;; -- Font --
;; ----------

(defvar preferred-fonts '("Source Code Pro" "Fira Mono" "DejaVu Sans Mono" "Monaco" "Ubuntu Mono" "Hack"))

(defvar current-font-size 10)

(if (display-graphic-p)
    (dolist (font preferred-fonts)
	  (if (member font (font-family-list))
		  (progn
			(set-frame-font (concat font " " (number-to-string current-font-size)) t)
			(message "Font: %s" font)
			(message "Font size: %d" current-font-size)
			(return)))))

;; -- Theme --
;; -----------

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
  		doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;;(load-theme 'doom-vibrant t)

  ;; preferred light theme
  ;;(load-theme 'doom-opera-light t)

  ;;(load-theme 'doom-molokai t)
  (load-theme 'doom-dracula t)
  (doom-themes-org-config)
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config))

;; preferred light theme
;; (use-package material-theme
;;   :ensure t
;;   :config
;;   (load-theme 'material-light t))

(use-package smart-mode-line
  :ensure t
  :config
  (setq sml/theme 'dark)

  ;; preferred for light theme
  ;;(setq sml/theme 'respectful)

  (setq sml/no-confirm-load-theme t)
  (sml/setup))

(if (version< emacs-version "25.3")
	(message "--> minions isn't supported in this version of Emacs")
  (use-package minions
	:ensure t
	:config (minions-mode 1)))

;;Show changes in the gutter
(use-package git-gutter
  :ensure t
  :diminish
  :config
  (global-git-gutter-mode 't)
  (set-face-background 'git-gutter:modified 'nil)   ;; background color
  (set-face-foreground 'git-gutter:added "green4")
  (set-face-foreground 'git-gutter:deleted "red"))


(provide 'appearance)

;;; appearance.el ends here
