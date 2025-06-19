;;; init-corfu.el --- Corfu in-buffer completion configuration

;;; Commentary:
;;
;; This file configures Corfu, a modern in-buffer completion UI for Emacs.
;; Corfu is part of the modern completion stack that includes Vertico and
;; Orderless, providing a more responsive and feature-rich completion experience.
;;
;; Key Features:
;; - In-buffer completion popup (not in minibuffer like Company)
;; - Automatic completion with configurable delay
;; - Terminal support via corfu-terminal
;; - Cape extensions for additional completion sources
;; - Integration with Orderless for flexible matching
;;
;; Dependencies:
;; - corfu: The main completion UI
;; - corfu-terminal: Terminal support (auto-loaded for non-GUI)
;; - cape: Completion at point extensions
;; - orderless: Flexible completion matching (configured separately)

;;; Code:

;; ============================================================================
;; CORFU - MODERN IN-BUFFER COMPLETION
;; ============================================================================

(use-package corfu
  :ensure t
  :after orderless
  :custom
  ;; Core completion behavior
  (corfu-auto t)                 ; Enable automatic completion
  (corfu-scroll-margin 5)        ; Scroll margin for candidate list
  
  ;; Optional customizations (disabled by default)
  ;; (corfu-cycle t)                ; Enable cycling through candidates
  ;; (corfu-separator ?\s)          ; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ; Configure handling of exact matches

  ;; Mode-specific activation (alternative to global mode)
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  :init
  ;; Enable Corfu globally for all modes that support completion-at-point
  ;; This is recommended since dabbrev and other completion sources work globally
  (global-corfu-mode))

;; ============================================================================
;; TERMINAL SUPPORT
;; ============================================================================

;; Enable terminal support when running in non-GUI mode
(unless (display-graphic-p)
  (use-package corfu-terminal
    :ensure t
    :after corfu
    :config
    (corfu-terminal-mode 1)))

;; ============================================================================
;; CAPE - COMPLETION AT POINT EXTENSIONS
;; ============================================================================

(use-package cape
  :ensure t
  
  ;; Key bindings for manual completion triggers
  ;; All bindings use the C-c p prefix for consistency
  :bind (("C-c p p" . completion-at-point) ; Default completion
         ("C-c p t" . complete-tag)        ; Etags completion
         ("C-c p d" . cape-dabbrev)        ; Dynamic abbreviations
         ("C-c p h" . cape-history)        ; Command history
         ("C-c p f" . cape-file)           ; File path completion
         ("C-c p k" . cape-keyword)        ; Programming keywords
         ("C-c p s" . cape-elisp-symbol)   ; Elisp symbols
         ("C-c p e" . cape-elisp-block)    ; Elisp code blocks
         ("C-c p a" . cape-abbrev)         ; Abbreviations
         ("C-c p l" . cape-line)           ; Line completion
         ("C-c p w" . cape-dict)           ; Dictionary words
         ("C-c p :" . cape-emoji)          ; Emoji completion
         ("C-c p \\" . cape-tex)           ; TeX symbols
         ("C-c p _" . cape-tex)            ; TeX symbols (alternative)
         ("C-c p ^" . cape-tex)            ; TeX symbols (alternative)
         ("C-c p &" . cape-sgml)           ; SGML/HTML entities
         ("C-c p r" . cape-rfc1345))       ; RFC1345 character mnemonics
  
  :init
  ;; Add completion sources to the global completion-at-point-functions
  ;; Order matters: first function returning results wins
  ;; Buffer-local functions take precedence over global ones
  
  ;; Core completion sources (enabled by default)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)     ; Dynamic abbreviations
  (add-to-list 'completion-at-point-functions #'cape-file)        ; File paths
  (add-to-list 'completion-at-point-functions #'cape-elisp-block) ; Elisp code blocks
  
  ;; Additional completion sources (disabled by default)
  ;; Uncomment to enable specific completion types
  ;;(add-to-list 'completion-at-point-functions #'cape-history)     ; Command history
  ;;(add-to-list 'completion-at-point-functions #'cape-keyword)     ; Programming keywords
  ;;(add-to-list 'completion-at-point-functions #'cape-tex)         ; TeX symbols
  ;;(add-to-list 'completion-at-point-functions #'cape-sgml)        ; SGML entities
  ;;(add-to-list 'completion-at-point-functions #'cape-rfc1345)     ; Character mnemonics
  ;;(add-to-list 'completion-at-point-functions #'cape-abbrev)      ; Abbreviations
  ;;(add-to-list 'completion-at-point-functions #'cape-dict)        ; Dictionary
  ;;(add-to-list 'completion-at-point-functions #'cape-elisp-symbol); Elisp symbols
  ;;(add-to-list 'completion-at-point-functions #'cape-line)        ; Line completion
  )

(provide 'init-corfu)

;;; init-corfu.el ends here
