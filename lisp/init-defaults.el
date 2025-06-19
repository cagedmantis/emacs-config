;;; init-defaults.el --- Core Emacs defaults and behavior configuration

;;; Commentary:
;;
;; This file contains fundamental Emacs configuration settings that establish
;; the basic behavior and user experience. It covers essential settings that
;; most users would want regardless of their specific use case.
;;
;; Key Areas:
;; - Clipboard and selection behavior
;; - File handling (auto-revert, backups, compression)
;; - UTF-8 encoding setup (centralized configuration)
;; - Buffer and window management
;; - User interaction improvements (y/n prompts, recent files)
;; - Performance optimizations (GC threshold, scrolling)
;; - Text editing behavior (indentation, line wrapping)
;; - Backup and auto-save configuration
;;
;; This module serves as the foundation that other modules build upon.

;;; Code:

;; ============================================================================
;; CLIPBOARD AND SELECTION
;; ============================================================================

;; Share the clipboard with X Window System and other GUI environments
(setq x-select-enable-clipboard t
	  select-enable-clipboard t)

;; Real emacs knights don't use shift to mark things (use C-SPC instead)
(setq shift-select-mode nil)

;; Remove text in active region if inserting text
(delete-selection-mode 1)

;; ============================================================================
;; FILE HANDLING
;; ============================================================================

;; Auto refresh buffers when files change on disk
(global-auto-revert-mode t)

;; Also auto refresh dired and other non-file buffers, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)

;; Move files to trash when deleting instead of permanent deletion
(setq delete-by-moving-to-trash t)

;; Transparently open compressed files (.gz, .bz2, etc.)
(auto-compression-mode t)

;; Enable syntax highlighting for older Emacs versions that have it off
(global-font-lock-mode t)

;; ============================================================================
;; USER INTERACTION IMPROVEMENTS
;; ============================================================================

;; Answering just 'y' or 'n' will do instead of 'yes' or 'no'
(defalias 'yes-or-no-p 'y-or-n-p)

;; Save a list of recent files visited (open recent file with C-x f)
(recentf-mode 1)
(setq recentf-max-saved-items 100) ; 20 is too few for active development

;; Save minibuffer history across sessions
(savehist-mode 1)
(setq history-length 1000)

;; Undo/redo window configuration with C-c <left>/<right>
(winner-mode 1)

;; ============================================================================
;; UTF-8 ENCODING (CENTRALIZED CONFIGURATION)
;; ============================================================================

;; Set UTF-8 as the default encoding for all systems
(setq locale-coding-system 'utf-8)       ; System locale
(set-terminal-coding-system 'utf-8)      ; Terminal communication
(set-keyboard-coding-system 'utf-8)      ; Keyboard input
(set-selection-coding-system 'utf-8)     ; Clipboard/selection
(prefer-coding-system 'utf-8)            ; Default for new files

;; ============================================================================
;; DISPLAY AND VISUAL BEHAVIOR
;; ============================================================================

;; Show active region with highlighting
(transient-mark-mode 1)
(make-variable-buffer-local 'transient-mark-mode)
(put 'transient-mark-mode 'permanent-local t)
(setq-default transient-mark-mode t)

;; Always display line and column numbers in mode line
(setq line-number-mode t)
(setq column-number-mode t)

;; Show empty lines after buffer end
(set-default 'indicate-empty-lines t)

;; ============================================================================
;; TEXT EDITING BEHAVIOR
;; ============================================================================

;; Lines should be 80 characters wide, not 72
(setq fill-column 80)

;; Easily navigate camelCase and snake_case words
(global-subword-mode 1)

;; Don't break lines automatically (prefer horizontal scrolling)
(setq-default truncate-lines t)

;; Keep cursor away from edges when scrolling up/down
(use-package smooth-scrolling
  :ensure t
  :config
  (smooth-scrolling-mode 1)
  (setq smooth-scroll-margin 5))

;; Allow recursive minibuffers
(setq enable-recursive-minibuffers t)

;; Don't be so stingy on the memory, we have lots now. It's the distant future.
(setq gc-cons-threshold 20000000)

;; org-mode: Don't ruin S-arrow to switch windows please (use M-+ and M-- instead to toggle)
(setq org-replace-disputed-keys t)

;; Fontify org-mode code blocks
(setq org-src-fontify-natively t)

;; Sentences do not need double spaces to end. Period.
(set-default 'sentence-end-double-space nil)

;; ;; 80 chars is a good width.
;; (set-default 'fill-column 80)

;; Add parts of each file's directory to the buffer name if not unique
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; A saner ediff
(setq ediff-diff-options "-w")
(setq ediff-split-window-function 'split-window-horizontally)
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; No electric indent
(setq electric-indent-mode nil)

;; Nic says eval-expression-print-level needs to be set to nil (turned off) so
;; that you can always see what's happening.
(setq eval-expression-print-level nil)

;; When popping the mark, continue popping until the cursor actually moves
;; Also, if the last command was a copy - skip past all the expand-region cruft.
(defadvice pop-to-mark-command (around ensure-new-position activate)
  (let ((p (point)))
    (when (eq last-command 'save-region-or-current-line)
      ad-do-it
      ad-do-it
      ad-do-it)
    (dotimes (i 10)
      (when (= p (point)) ad-do-it))))

(setq set-mark-command-repeat-pop t)

;; Offer to create parent directories if they do not exist
;; http://iqbalansari.github.io/blog/2014/12/07/automatically-create-parent-directories-on-visiting-a-new-file-in-emacs/
(defun my-create-non-existent-directory ()
  (let ((parent-directory (file-name-directory buffer-file-name)))
    (when (and (not (file-exists-p parent-directory))
               (y-or-n-p (format "Directory `%s' does not exist! Create it?" parent-directory)))
      (make-directory parent-directory t))))

(add-to-list 'find-file-not-found-functions 'my-create-non-existent-directory)

(setq shell-file-name "/bin/bash")             ; Set Shell for M-| command
(setq sentence-end-double-space nil)           ; Sentences end with one space
(setq-default indent-tabs-mode nil)            ; Use spaces instead of tabs
(setq visible-bell t)                          ; No beep when reporting errors

;;El Capitan fix
(setq visible-bell nil) ;; The default
(setq ring-bell-function 'ignore)

(setq ispell-dictionary "english")             ; Set ispell dictionary
(setq make-backup-files t)                     ; backup files ~

;; Save a list of recent files visited.
(recentf-mode 1)

(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
    (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
      )

(use-package smartparens
  :ensure t)

(setq auto-window-vscroll nil)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(provide 'init-defaults)

;;; init-defaults.el ends here
