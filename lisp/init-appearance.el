;;; init-appearance.el --- appearance configuration

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

;; Add the powerline version of fonts to local machine.
;; Set the terminals to use the powerline version of the fonts.
(defvar preferred-fonts '("Source Code Pro" "Fira Mono" "DejaVu Sans Mono" "Monaco" "Ubuntu Mono" "Hack"))

(defvar current-font-size 10)

(if (display-graphic-p)
    (dolist (font preferred-fonts)
	  (if (member font (font-family-list))
		  (progn
			(set-frame-font (concat font " " (number-to-string current-font-size)) t)
			(set-frame-font font nil t)
			(message "Font: %s" font)
			(message "Font size: %d" current-font-size)))))

(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t         ; if nil, bold is universally disabled
  		doom-themes-enable-italic t       ; if nil, italics is universally disabled
		doom-themes-org-config t
		doom-themes-visual-bell-config t)
  (load-theme 'doom-molokai t))   ; Enable flashing mode-line on errors

(use-package telephone-line
  :ensure t
  :init
  (telephone-line-mode 1)
  :custom
  (setq telephone-line-lhs
		'((evil   . (telephone-line-evil-tag-segment))
		  (accent . (telephone-line-vc-segment
					 telephone-line-erc-modified-channels-segment
					 telephone-line-process-segment))
		  (nil    . (telephone-line-minor-mode-segment
					 telephone-line-buffer-segment))))
  (setq telephone-line-rhs
		'((nil    . (telephone-line-misc-info-segment))
		  (accent . (telephone-line-major-mode-segment))
		  (evil   . (telephone-line-airline-position-segment)))))

(provide 'init-appearance)
;;; init-appearance.el ends here
