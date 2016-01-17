;; Emacs config
;; config-default.el
;; Author: Carlos Amedee

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))  ; Disable the scrollbar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))      ; Disable the toolbar
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))      ; Disable the menubar

(setq inhibit-startup-message t)               ; No message at startup
(setq shell-file-name "/bin/bash")             ; Set Shell for M-| command
(setq sentence-end-double-space nil)           ; Sentences end with one space
(setq-default indent-tabs-mode nil)            ; Use spaces instead of tabs
(column-number-mode t)                         ; Show column number in mode-line
(global-font-lock-mode t)		       ; fonts are automatically highlighted
(setq visible-bell t)                          ; No beep when reporting errors

;;El Capitan fix
(setq visible-bell nil) ;; The default
(setq ring-bell-function 'ignore)

(defalias 'yes-or-no-p 'y-or-n-p)              ; y/n instead of yes/no
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
(setq color-theme-is-global t)
(setq mouse-yank-at-point t)
(setq require-final-newline t)
(setq truncate-partial-width-windows nil)
(setq uniquify-buffer-name-style 'forward)
(setq ffap-machine-p-known 'reject)
(setq xterm-mouse-mode t)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(ansi-color-for-comint-mode-on)

(auto-compression-mode t) ;; Transparently open compressed files

;; Enable syntax highlighting for older Emacsen that have it off
(global-font-lock-mode t)

;; Save a list of recent files visited.
(recentf-mode 1)

;; Default to unified diffs
(setq diff-switches "-u -w"
      magit-diff-options "-w")

;; Line by line scrolling
(setq scroll-step            1
      scroll-conservatively  10000)

;; Set window title to file name
(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (tooltip-mode -1)
  (mouse-wheel-mode t)
  (blink-cursor-mode -1))


;; Backup files go into a backup dir
(setq backup-directory-alist `(("." . ,(expand-file-name
                                        (concat dotfiles-dir "backups")))))

;; disable line mode for listed modes
(setq linum-disabled-modes-list '(shell-mode eshell-mode wl-summary-mode compilation-mode fundamental-mode))
    (defun linum-on ()
      (unless (or (minibufferp) (member major-mode linum-disabled-modes-list))
        (linum-mode 1)))


(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)

; Share the clipboard with X
(setq x-select-enable-clipboard t)

;; Enable proper color interpretation in emacs shell mode
;;(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)

(provide 'config-default)
