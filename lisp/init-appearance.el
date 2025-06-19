;;; init-appearance.el --- Visual appearance and UI configuration

;;; Commentary:
;;
;; This file configures the visual appearance and user interface of Emacs.
;; It handles themes, fonts, UI elements, and visual enhancements to create
;; a modern, clean, and functional editing environment.
;;
;; Key Features:
;; - Clean UI (removes toolbars, scrollbars, menu bars)
;; - Line numbers and visual indicators
;; - Font selection with automatic fallbacks
;; - Modern Doom themes with modeline
;; - Whitespace management and visualization
;; - Window dividers and visual enhancements
;; - Performance optimizations for display
;;
;; Dependencies:
;; - doom-themes: Modern theme collection
;; - doom-modeline: Enhanced modeline
;; - nerd-icons: Icon support
;; - solaire-mode: Better buffer distinction
;; - whitespace: Whitespace visualization

;;; Code:
;; ============================================================================
;; CLEAN UI - REMOVE UNNECESSARY GUI ELEMENTS
;; ============================================================================

(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))  ; Remove scrollbar
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))      ; Remove toolbar
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))      ; Remove menu bar

;; ============================================================================
;; BASIC DISPLAY SETTINGS
;; ============================================================================

(setq inhibit-startup-message t)               ; Skip Emacs startup screen
(column-number-mode t)                         ; Show column number in mode-line
(line-number-mode 1)                           ; Show line number in mode-line
(global-font-lock-mode t)                      ; Enable syntax highlighting
(size-indication-mode t)                       ; Show buffer size in mode-line
(show-paren-mode 1)                            ; Highlight matching parentheses
(global-visual-line-mode 1)                    ; Soft wrap long lines

;; Enable line numbers for Emacs 26+ (better than linum-mode)
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode t)
  (setq display-line-numbers " %4d "))         ; Format with padding

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
  :ensure t
  :config
  (setq whitespace-line-column 80) ;; limit line length
  (setq whitespace-style '(face tabs empty trailing lines-tail))
  (add-hook 'before-save-hook 'delete-trailing-whitespace))

;; Vertical window divider
(setq window-divider-default-right-width 3)
(setq window-divider-default-places 'right-only)
(window-divider-mode)

(use-package diminish
  :ensure t)

(defvar current-font-size 11)

(defun set-font (font)
  "Set the FONT and size."
  (set-frame-font (concat font " " (number-to-string current-font-size)) t)
  (set-frame-font font nil t)
  (message "Font: %s Size: %d" font current-font-size))

;; needs cleanup
(if (display-graphic-p)
    (cond
     ((member "Source Code Pro" (font-family-list))
      (set-font "Source Code Pro"))
     ((member "Fira Mono" (font-family-list))
      (set-font "Fira Mono"))
     ((member "DejaVu Sans Mono" (font-family-list))
      (set-font "DejaVu Sans Mono"))
     ((member "Monaco" (font-family-list))
      (set-font "Monaco"))
     ((member "Ubuntu Mono" (font-family-list))
      (set-font "Ubuntu Mono"))
     ((member "Hack" (font-family-list))
      (set-font "Hack"))
     ((t)
      (message "Using default system font"))))

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
