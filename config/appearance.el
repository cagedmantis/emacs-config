;;; appearance.el --- appearance configuration

;;; Commentary:

;;; Code:

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))  ; Disable the scrollbar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))      ; Disable the toolbar
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))      ; Disable the menubar

(setq inhibit-startup-message t)               ; No message at startup
(column-number-mode t)                         ; Show column number in mode-line
(line-number-mode 1)                           ; show line number the cursor is on, in status bar (the mode line)
(global-linum-mode 1)                          ; always show line numbers
(global-font-lock-mode t)		               ; fonts are automatically highlighted
(size-indication-mode t)
(show-paren-mode 1)                            ; turn on paren match highlighting
(setq linum-format " %d ")                     ; fixes bug where line numbers are not buffered in visual-line-mode
(global-visual-line-mode 1)                    ; Soft wrap lines

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

;; disable line mode for listed modes
(setq linum-disabled-modes-list '(shell-mode ansi-term term-mode eshell-mode wl-summary-mode compilation-mode fundamental-mode))
(defun linum-on ()
  (unless (or (minibufferp) (member major-mode linum-disabled-modes-list))
    (linum-mode 1)))

;;store all autosave files
(setq auto-save-file-name-transforms
      `((".*" ,"~/.emacs.d/auto-save-list" t)))

(setq font-lock-maximum-decoration t
      truncate-partial-width-windows nil)

;; Don't defer screen updates when performing operations
(setq redisplay-dont-pause t)

;; Unclutter the modeline
(use-package diminish
  :ensure t
  :config
  (eval-after-load "yasnippet" '(diminish 'yas-minor-mode))
  (eval-after-load "eldoc" '(diminish 'eldoc-mode))
  (eval-after-load "paredit" '(diminish 'paredit-mode))
  (eval-after-load "tagedit" '(diminish 'tagedit-mode))
  (eval-after-load "elisp-slime-nav" '(diminish 'elisp-slime-nav-mode))
  (eval-after-load "skewer-mode" '(diminish 'skewer-mode))
  (eval-after-load "skewer-css" '(diminish 'skewer-css-mode))
  (eval-after-load "skewer-html" '(diminish 'skewer-html-mode))
  (eval-after-load "smartparens" '(diminish 'smartparens-mode))
  (eval-after-load "guide-key" '(diminish 'guide-key-mode))
  (eval-after-load "whitespace-cleanup-mode" '(diminish 'whitespace-cleanup-mode))
  (eval-after-load "subword" '(diminish 'subword-mode))
  (eval-after-load "eldoc" '(diminish 'eldoc-mode))
  (eval-after-load "autopair" '(diminish 'autopair-mode))
  (eval-after-load "abbrev" '(diminish 'abbrev-mode))
  (eval-after-load "js2-highlight-vars" '(diminish 'js2-highlight-vars-mode))
  (eval-after-load "mmm-mode" '(diminish 'mmm-mode))
  (eval-after-load "skewer-html" '(diminish 'skewer-html-mode))
  (eval-after-load "skewer-mode" '(diminish 'skewer-mode))
  (eval-after-load "auto-indent-mode" '(diminish 'auto-indent-minor-mode))
  (eval-after-load "cider" '(diminish 'cider-mode))
  (eval-after-load "smartparens" '(diminish 'smartparens-mode)))

(setq linum-format (if (not window-system) "%4d " "%4d"))

;; Highlight the line number of the current line.
(use-package hlinum
  :ensure t
  :config
  (hlinum-activate))

;; Ensure linum-mode is disabled in certain major modes.
(setq linum-disabled-modes
      '(term-mode slime-repl-mode magit-status-mode help-mode nrepl-mode
				  mu4e-main-mode mu4e-headers-mode mu4e-view-mode
				  mu4e-compose-mode))

(defun linum-on ()
  (unless (or (minibufferp) (member major-mode linum-disabled-modes))
    (linum-mode 1)))

;; Indent guides
(use-package highlight-indent-guides
  :ensure t
  :hook (prog-mode . highlight-indent-guides-mode)
  :config (setq highlight-indent-guides-method 'column))

;; Modeline - hai2nan
(when window-system
  (use-package moody
    :ensure t
    :config
    (setq x-underline-at-descent-line t)
    (setq moody-mode-line-height 24)
    (setq moody-slant-function #'moody-slant-apple-rgb)
    (moody-replace-mode-line-buffer-identification)
    (moody-replace-vc-mode)))

(add-hook 'prog-mode-hook (lambda ()
                            (interactive)
                            (setq show-trailing-whitespace 1)))

;; Reduce scroll lag
;; https://emacs.stackexchange.com/questions/28736/emacs-pointcursor-movement-lag/28746
(setq auto-window-vscroll nil)

(setq font-lock-maximum-decoration t)

(use-package whitespace
  :ensure t
  :config
  (require 'whitespace))

(use-package dimmer
  :ensure t
  :config
  (dimmer-mode)
  (setq dimmer-fraction 0.50))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; -- Font --
;; ----------

;; Change the font and size

;; Does a font exist?
(defun font-existsp (font)
  (if (display-graphic-p)
	  (if (null (x-list-fonts font))
		  nil t))
  )

;; (if (font-existsp preferred-font)
;;     (set-default-font preferred-font)
;;   (set-default-font "DejaVu Sans Mono"))

(defvar preferred-fonts '("Fira Mono"
                          "Source Code Pro"
                          "DejaVu Sans Mono"
						  "Monaco"
						  "Ubuntu Mono"
						  "Hack"))

;; Set font for linux and misc.
(if (eq system-type 'gnu/linux)
	(if (display-graphic-p)
		(if (font-existsp "Ubuntu Mono")
			(set-frame-font "Ubuntu Mono" nil t)
		  (set-frame-font "Monaco" nil t))
	  (set-frame-font "Source Code Pro"))
  )

;;(set-frame-font "Source Code Pro for Powerline" nil t)

;;(set-face-attribute 'default nil :height 100)


;; experimental
;;(set-frame-font "Fira Code")


;; -- Theme --
;; -----------

(use-package color-theme
  :ensure t
  :config
  (setq color-theme-is-global t)
  (color-theme-initialize)

  (use-package doom-themes
    :ensure t
    :config
    (load-theme 'doom-vibrant t)
    (doom-themes-org-config)))

(use-package smart-mode-line
  :ensure t
  :config
  (setq sml/theme 'dark)
  (setq sml/no-confirm-load-theme t)
  (sml/setup))

(provide 'appearance)

;;; appearance.el ends here
