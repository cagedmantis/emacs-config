;;; init-orderless.el --- Orderless completion style configuration

;;; Commentary:
;;
;; This file configures Orderless, a completion style for Emacs that allows
;; flexible matching of completion candidates. Orderless enables space-separated
;; search terms to match candidates in any order, providing a more intuitive
;; and powerful completion experience.
;;
;; Key Features:
;; - Space-separated multi-term matching (terms can be in any order)
;; - Integrates with any completion UI (Vertico, Corfu, Company, etc.)
;; - Flexible matching styles (literal, regexp, fuzzy, etc.)
;; - File path completion with partial-completion fallback
;;
;; Matching Examples:
;; - "init pack" matches "init-package.el"
;; - "buf swit" matches "switch-buffer"
;; - "git com" matches "magit-commit"
;;
;; Configuration:
;; - Primary completion style for most contexts
;; - Basic completion as fallback for compatibility
;; - File completion uses partial-completion for path segments
;; - Supports custom style dispatchers for specialized matching
;;
;; Integration:
;; - Works with Vertico for minibuffer completion
;; - Works with Corfu for in-buffer completion
;; - Compatible with all Emacs completion systems
;;
;; Dependencies:
;; - orderless: Flexible completion matching

;;; Code:

;; Optionally use the `orderless' completion style.
(use-package orderless
  :ensure t
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(provide 'init-orderless)

;;; init-orderless.el ends here
