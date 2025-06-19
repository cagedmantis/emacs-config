;;; init-company.el --- Company completion framework configuration

;;; Commentary:
;;
;; This file configures Company mode, a text completion framework for Emacs.
;; Company provides pop-up completions for programming and text editing.
;;
;; Note: This configuration is maintained for compatibility, but the main
;; completion system now uses the modern Vertico + Corfu + Orderless stack.
;; Company may be redundant with Corfu enabled.
;;
;; Features:
;; - Global company mode enabled
;; - Popup tooltip with annotations
;; - Fast completion with reduced delay
;; - Custom completion behavior settings
;;
;; Dependencies:
;; - company: The completion framework

;;; Code:

(use-package company
  :ensure t
  :config
  ;; Enable Company mode globally after initialization
  (add-hook 'after-init-hook 'global-company-mode)

  ;; Completion behavior configuration
  (setq company-tooltip-align-annotations t)            ; Align annotations in tooltip
  (setq company-dabbrev-downcase nil)                   ; Don't downcase completions
  (setq company-tooltip-limit 20)                       ; Show more candidates in popup
  (setq company-idle-delay .25)                         ; Faster popup display (default: 0.5)
  (setq company-echo-delay 0)                           ; No delay for echo area
  (setq company-begin-commands '(self-insert-command))) ; Only complete after typing

  ;; Custom backends configuration (disabled - using default)
  ;; Uncomment and customize if you need specific completion sources
  ;;(setq company-backends '((company-capf company-dabbrev-code company-etags company-keywords company-yasnippet)
  ;;                         (company-files company-dabbrev company-abbrev company-ispell))))

(provide 'init-company)

;;; init-company.el ends here
