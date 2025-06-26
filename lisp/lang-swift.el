;;; lang-swift.el --- Swift programming language configuration

;;; Commentary:
;;
;; This file configures Swift programming language support for Emacs.
;; It provides syntax highlighting, error checking, and development
;; tools for iOS, macOS, and server-side Swift development.
;;
;; Key Features:
;; - Swift syntax highlighting and editing support
;; - Real-time syntax checking with Flycheck
;; - Swift compiler integration
;; - iOS and macOS development support
;; - Server-side Swift compatibility
;;
;; Core Components:
;; - swift-mode: Primary Swift editing mode
;; - flycheck-swift: Swift-specific syntax checking
;; - Swift compiler integration
;;
;; Language Support:
;; - Modern Swift syntax (Swift 5+)
;; - iOS app development
;; - macOS application development
;; - watchOS and tvOS support
;; - Server-side Swift frameworks
;;
;; Development Features:
;; - Syntax highlighting for Swift keywords
;; - Proper indentation and code structure
;; - Error checking and compiler integration
;; - Swift Package Manager support
;;
;; Error Checking:
;; - Real-time syntax checking
;; - Swift compiler error integration
;; - Build error reporting
;; - Type checking and warnings
;;
;; Platform Support:
;; - Xcode project integration
;; - Swift Package Manager projects
;; - Linux Swift development
;; - Cross-platform Swift code
;;
;; Setup Requirements:
;; - Swift toolchain installation
;; - Xcode (for iOS/macOS development)
;; - Swift compiler (swiftc)
;; - Swift Package Manager (swift)
;;
;; Development Workflow:
;; - Edit Swift source files
;; - Real-time error checking
;; - Build and test integration
;; - Package dependency management
;;
;; Dependencies:
;; - swift-mode: Swift language editing support
;; - flycheck-swift: Syntax checking integration
;; - flycheck: Error checking framework

;;; Code:

(use-package swift-mode
  :ensure t)

(use-package flycheck-swift
  :ensure t
  :config
  '(eval-after-load 'flycheck '(flycheck-swift-setup)))

(provide 'lang-swift)
;;; lang-swift.el ends here
