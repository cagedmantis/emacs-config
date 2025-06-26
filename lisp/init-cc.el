;;; init-cc.el --- C/C++ programming mode configuration

;;; Commentary:
;;
;; This file provides basic configuration for C and C++ programming modes.
;; It sets up fundamental coding standards, indentation, and key bindings
;; for C/C++ development.
;;
;; Key Features:
;; - Linux-style indentation (4 spaces, tabs preferred)
;; - Automatic indentation on newline
;; - Consistent C/C++ coding style configuration
;;
;; Configuration Details:
;; - Basic offset: 4 characters for indentation
;; - Default style: Linux kernel coding style
;; - Tab width: 4 characters
;; - Uses tabs for indentation (not spaces)
;; - RET key bound to newline-and-indent for automatic indentation
;;
;; This configuration affects all CC-mode derived modes including:
;; - c-mode (C programming)
;; - c++-mode (C++ programming)
;; - objc-mode (Objective-C programming)
;; - java-mode (Java programming)

;;; Code:

(require 'cc-mode)

(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode t)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

(provide 'init-cc)

;;; init-cc.el ends here
