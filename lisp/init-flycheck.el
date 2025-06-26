;;; init-flycheck.el --- On-the-fly syntax checking configuration

;;; Commentary:
;;
;; This file configures Flycheck, an on-the-fly syntax checking framework
;; for Emacs. Flycheck provides real-time feedback on syntax errors,
;; warnings, and other issues while you write code.
;;
;; Key Features:
;; - Global flycheck mode for all supported modes
;; - Custom error display styling with colored underlines
;; - Dedicated error buffer with smart positioning
;; - Tooltip error messages for better user experience
;; - Shell script specific error checking
;;
;; Visual Styling:
;; - Errors: Red wavy underlines with red text
;; - Warnings: Yellow wavy underlines with yellow text  
;; - Info: Green wavy underlines with green text
;;
;; Error Buffer:
;; - Displays in bottom side window
;; - Takes up 33% of frame height
;; - Reuses existing window when possible
;;
;; Dependencies:
;; - flycheck: Core syntax checking framework
;; - flycheck-pos-tip: Tooltip error display
;; - diminish: Hide minor mode from modeline

;;; Code:

(use-package flycheck
  :ensure t
  :diminish
  :init (global-flycheck-mode)
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (add-hook 'sh-mode-hook 'flycheck-mode)
  (set-face-attribute 'flycheck-warning nil
        	      :underline `(:style wave :color "yellow")
        	      :foreground "yellow")

  (set-face-attribute 'flycheck-error nil
        	      :underline `(:style wave :color "red")
        	      :foreground "red")

  (set-face-attribute 'flycheck-info nil
        	      :underline `(:style wave :color "green")
        	      :foreground "green")

  (add-to-list 'display-buffer-alist
               `(,(rx bos "*Flycheck errors*" eos)
        	 (display-buffer-reuse-window
        	  display-buffer-in-side-window)
        	 (side            . bottom)
        	 (reusable-frames . visible)
        	 (window-height   . 0.33)))

  ;; (use-package flycheck-color-mode-line
  ;;       :ensure t
  ;;       :config
  ;;       (require 'flycheck-color-mode-line)

  ;;       (eval-after-load "flycheck"
  ;;         '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)))

  (use-package flycheck-pos-tip
    :ensure t
    :config
    (with-eval-after-load 'flycheck
      (flycheck-pos-tip-mode)))
  )

(provide 'init-flycheck)

;;; init-flycheck.el ends here
