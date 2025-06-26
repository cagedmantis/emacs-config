;;; init-switch-window.el --- Enhanced window switching configuration

;;; Commentary:
;;
;; This file configures enhanced window switching capabilities for Emacs.
;; It provides two complementary systems for efficient navigation between
;; multiple windows in complex layouts.
;;
;; Key Components:
;; - switch-window: Visual window selection with numbered overlays
;; - ace-window: Quick window switching with customizable key labels
;;
;; Switch-Window Features:
;; - Numbered overlays on each window for visual selection
;; - Replaces the default C-x o (other-window) behavior
;; - Better for layouts with many windows
;; - Clear visual feedback for window targeting
;;
;; Ace-Window Features:
;; - Home row key labels (a,s,d,f,g,h,j,k,l) for quick access
;; - Accessible via M-o binding
;; - Efficient for power users familiar with home row typing
;; - Customizable key sequence for window selection
;;
;; Usage Patterns:
;; - C-x o: switch-window (visual numbered selection)
;; - M-o: ace-window (home row key selection)
;; - Choose the method that fits your workflow
;;
;; Window Layout Support:
;; - Works with any window configuration
;; - Supports multiple frames
;; - Integrates with split-window operations
;;
;; Dependencies:
;; - switch-window: Numbered window selection
;; - ace-window: Key-based window navigation

;;; Code:

(use-package switch-window
  :ensure t
  :config

  (global-set-key (kbd "C-x o") 'switch-window))

(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "M-o") 'ace-window)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  )

(provide 'init-switch-window)

;;; init-switch-window.el ends here
