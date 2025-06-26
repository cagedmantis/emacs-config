;;; lang-cpp.el --- C++ development environment configuration

;;; Commentary:
;;
;; This file configures a comprehensive C++ development environment for Emacs.
;; It provides intelligent code completion, syntax checking, formatting, and
;; documentation features through Irony mode and related packages.
;;
;; Key Features:
;; - Intelligent code completion via libclang
;; - Real-time syntax checking and error reporting
;; - Automatic code formatting with clang-format
;; - Function signature help in echo area
;; - Integration with compilation databases
;;
;; Core Components:
;; - Irony: C++ completion and syntax analysis using libclang
;; - Company-irony: Code completion integration
;; - Flycheck-irony: Real-time error checking
;; - Irony-eldoc: Function signature documentation
;; - Clang-format: Code formatting and style enforcement
;;
;; Setup Requirements:
;; - macOS: brew install cmake llvm
;; - Linux: Install clang, cmake, and development headers
;; - Irony server compilation (automatic on first use)
;;
;; Code Completion:
;; - Context-aware suggestions from libclang
;; - Member completion for classes and structs
;; - Template parameter suggestions
;; - Standard library completion
;;
;; Syntax Checking:
;; - Real-time error and warning reporting
;; - Integration with compilation databases
;; - Support for complex build configurations
;; - Customizable error display
;;
;; Code Formatting:
;; - LLVM style formatting by default
;; - Format on save for consistent code style
;; - Region and buffer formatting commands
;; - Customizable formatting rules
;;
;; Key Bindings:
;; - C-c i: clang-format-region (format selected region)
;; - C-c u: clang-format-buffer (format entire buffer)
;;
;; Dependencies:
;; - irony: Core C++ analysis engine
;; - company-irony: Completion integration
;; - flycheck-irony: Syntax checking
;; - irony-eldoc: Documentation display
;; - clang-format: Code formatting tool

;;; Code:

;; osx: brew install cmake llvm

(use-package irony
  :ensure t
  :config
  (progn
    ;; If irony server was never installed, install it.
    ;;(unless (irony--find-server-executable) (call-interactively #'irony-install-server))

    (add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode)

    ;; Use compilation database first, clang_complete as fallback.
    (setq-default irony-cdb-compilation-databases '(irony-cdb-libclang
						    irony-cdb-clang-complete))

    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
    ))

;; I use irony with company to get code completion.
(use-package company-irony
  :ensure t
  :requires company irony
  :config
  (progn
    (eval-after-load 'company '(add-to-list 'company-backends 'company-irony))))

;; I use irony with flycheck to get real-time syntax checking.
(use-package flycheck-irony
  :ensure t
  :requires flycheck irony
  :config
  (progn
    (eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))))

;; Eldoc shows argument list of the function you are currently writing in the echo area.
(use-package irony-eldoc
  :ensure t
  :requires eldoc irony
  :config
  (progn
    (add-hook 'irony-mode-hook #'irony-eldoc)))

(use-package clang-format
  :ensure t
  :config
  (global-set-key (kbd "C-c i") 'clang-format-region)
  (global-set-key (kbd "C-c u") 'clang-format-buffer)

  (setq clang-format-style-option "llvm")

  (add-hook 'c-mode-common-hook
	    (function (lambda ()
			(add-hook 'before-save-hook
				  'clang-format-buffer)))))


(provide 'lang-cpp)
;;; lang-cpp.el ends here
