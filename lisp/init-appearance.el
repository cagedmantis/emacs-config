;;; init-appearance.el --- appearance configuration  -*- lexical-binding: t; -*-

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

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode t)
  (setq display-line-numbers " %4d "))

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

(add-hook 'prog-mode-hook (lambda ()
                            (interactive)
                            (setq show-trailing-whitespace 1)))

;; Reduce scroll lag
;; https://emacs.stackexchange.com/questions/28736/emacs-pointcursor-movement-lag/28746
(setq auto-window-vscroll nil)

(use-package whitespace
  :ensure nil  ; built-in
  :config
  (setq whitespace-line-column 80) ;; limit line length
  (setq whitespace-style '(face tabs empty trailing lines-tail)))

;; Trim trailing whitespace on save, but only on lines actually edited, so
;; saving a file with pre-existing whitespace doesn't create noisy unrelated
;; diffs (replaces a global `delete-trailing-whitespace' before-save hook).
(use-package ws-butler
  :ensure t
  :config
  (ws-butler-global-mode 1))

;; Vertical window divider
(setq window-divider-default-right-width 3)
(setq window-divider-default-places 'right-only)
(window-divider-mode)

(use-package diminish
  :ensure t)

(defvar current-font-size 18
  "Default font size, in points.")

(defvar preferred-fonts
  '("Source Code Pro" "Fira Mono" "DejaVu Sans Mono" "Monaco" "Ubuntu Mono" "Hack")
  "Fonts to use, in order of preference.")

(defun set-font (font)
  "Set the default FONT family at `current-font-size'.
Use `set-face-attribute' with separate :family and :height rather than
`set-frame-font', because a string like \"Source Code Pro 14\" is parsed
as a single family name (multi-word names swallow the size), leaving a
tiny fallback font.  Also seed `default-frame-alist' so new frames
\(e.g. emacsclient frames) inherit the same font."
  (set-face-attribute 'default nil :family font :height (* current-font-size 10))
  (setf (alist-get 'font default-frame-alist)
        (format "%s-%d" font current-font-size))
  (message "Font: %s Size: %d" font current-font-size))

(defun set-preferred-font (&optional frame)
  "Apply the first available `preferred-fonts' entry to FRAME.
Runs per-frame via `after-make-frame-functions' so that emacsclient
and `emacs --daemon' frames get the font too -- the font can only be
chosen once a graphical frame exists, which for a daemon is not at
startup but when the first client frame is created."
  (with-selected-frame (or frame (selected-frame))
    (when (display-graphic-p)
      (let ((font (seq-find (lambda (f) (member f (font-family-list)))
                            preferred-fonts)))
        (if font
            (set-font font)
          (message "Using default system font"))))))

(add-hook 'after-make-frame-functions #'set-preferred-font)
(set-preferred-font)  ; covers the non-daemon (direct GUI) startup frame

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-acario-dark t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use "doom-colors" for less minimal icon theme
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package nerd-icons
  :ensure t)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-unicode-fallback t)
  (setq doom-modeline-env-version t)
  (setq doom-modeline-lsp t)
  (setq doom-modeline-modal-modern-icon t)
  (setq doom-modeline-vcs-max-length 30)
  (unless (display-graphic-p)
    (setq doom-modeline-icon nil))
  )

(use-package solaire-mode
  :ensure t
  :init (solaire-global-mode +1))

(provide 'init-appearance)
;;; init-appearance.el ends here
