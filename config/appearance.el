;;; appearance.el --- appearance configuration

;;; Commentary:

;;; Code:

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))  ; Disable the scrollbar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))      ; Disable the toolbar
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))      ; Disable the menubar

(setq inhibit-startup-message t)               ; No message at startup
(setq shell-file-name "/bin/bash")             ; Set Shell for M-| command
(setq sentence-end-double-space nil)           ; Sentences end with one space
(setq-default indent-tabs-mode nil)            ; Use spaces instead of tabs
(column-number-mode t)                         ; Show column number in mode-line
(global-font-lock-mode t)		               ; fonts are automatically highlighted
(setq visible-bell t)                          ; No beep when reporting errors
(size-indication-mode t)

;;El Capitan fix
(setq visible-bell nil) ;; The default
(setq ring-bell-function 'ignore)

(setq ispell-dictionary "english")             ; Set ispell dictionary
(setq make-backup-files t)                     ; backup files ~
(show-paren-mode 1)                            ; turn on paren match highlighting
(line-number-mode 1)                           ; show line number the cursor is on, in status bar (the mode line)
(global-linum-mode 1)                          ; always show line numbers
(setq linum-format " %d ")                     ; fixes bug where line numbers are not buffered in visual-line-mode
(global-visual-line-mode 1)                    ; Soft wrap lines

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

;; Enable syntax highlighting for older Emacsen that have it off
(global-font-lock-mode t)

;; Save a list of recent files visited.
(recentf-mode 1)

;; Default to unified diffs
(setq diff-switches "-u -w"
      magit-diff-options "-w")

;; Set window title to file name
(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (mouse-wheel-mode t)
  (blink-cursor-mode -1))

;; Backup files go into a backup dir
(setq backup-by-copying t                                       ; don't clobber symlinks
	  backup-directory-alist '(("." . "~/.emacs.d/backups"))    ; don't litter my fs tree
	  delete-old-versions t
	  kept-new-versions 6
	  kept-old-versions 2
	  version-control t)                                        ; use versioned backups

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

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (blink-cursor-mode -1))

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

;; Show current function in modeline.
;; (which-function-mode)

;; Ensure linum-mode is disabled in certain major modes.
(setq linum-disabled-modes
      '(term-mode slime-repl-mode magit-status-mode help-mode nrepl-mode
				  mu4e-main-mode mu4e-headers-mode mu4e-view-mode
				  mu4e-compose-mode))

(defun linum-on ()
  (unless (or (minibufferp) (member major-mode linum-disabled-modes))
    (linum-mode 1)))

(provide 'appearance)

;;; appearance.el ends here
