;;; init.el --- Main Emacs configuration entry point

;;; Commentary:
;;
;; This is the main entry point for a modular Emacs configuration.
;; It sets up load paths, loads core functionality, and conditionally
;; loads platform-specific configurations.
;;
;; Configuration Structure:
;; - Core modules are loaded from lisp/ directory
;; - Platform-specific code is loaded from system_type/ directory
;; - Language support is modular and can be enabled/disabled
;; - An Emacs server is started automatically if not already running
;;
;; Key Features:
;; - Modern completion with Vertico/Orderless/Corfu
;; - Language Server Protocol (LSP) support
;; - Go development environment (primary focus)
;; - Git integration and project management
;; - Spell checking and syntax checking

;;; Code:
;; Setup load paths for modular configuration
(add-to-list 'load-path "~/bin/")                                    ; User binaries
(add-to-list 'load-path (concat user-emacs-directory "/lisp"))       ; Core modules
(add-to-list 'load-path (concat user-emacs-directory "/system_type")) ; Platform-specific modules

;; Configure Emacs to use separate files for autoloads and customizations
(setq autoload-file (concat user-emacs-directory "loaddefs.el"))
(setq custom-file (concat user-emacs-directory "custom.el"))

;; Core package management
(require 'init-package)

;; Essential configurations
(require 'init-defaults)        ; Basic Emacs settings and UTF-8 configuration
(require 'init-appearance)      ; UI/UX settings and themes
;;(require 'init-ivy)           ; Alternative completion system (disabled)

;; Text editing enhancements  
;; (require 'init-autoinsert)   ; Auto-insert templates (disabled)
;; (require 'init-cc)           ; C/C++ configuration (disabled)
(require 'init-company)         ; Legacy completion system
(require 'init-yasnippet)       ; Code snippet expansion
(require 'init-spelling)        ; Spell checking with flyspell

;; Modern completion stack (Vertico ecosystem)
(require 'init-orderless)       ; Flexible matching for completion
(require 'init-corfu)          ; In-buffer completion UI
(require 'init-vertico)        ; Minibuffer completion UI
(require 'init-treemacs)       ; File tree explorer

;; Development tools
(require 'init-flycheck)        ; Syntax checking
(require 'init-language-server) ; LSP integration for IDE features
;; (require 'init-latex)        ; LaTeX support (disabled)
;; (require 'init-org)          ; Org-mode configuration (disabled)

;; Project management
;; TODO: work to migrate to project.el
(require 'init-projectile)      ; Project interaction library
;; (require 'init-rainbow-delimiters) ; Colorful parentheses (disabled)
;; (require 'init-saveplace)    ; Remember cursor position (disabled)
;; (require 'init-switch-window) ; Window switching (disabled)
;; (require 'init-utils)        ; Utility functions (disabled)

;; Version control
(require 'init-git)            ; Git integration with Magit

;; Language-specific configurations
(require 'lang-go)             ; Go development (primary language)
(require 'lang-modes)          ; Basic modes for various file types
;; (require 'lang-rust)        ; Rust development (disabled)
;; (require 'lang-cpp)         ; C++ development (disabled)
;; (require 'lang-javascript)  ; JavaScript development (disabled)
;; (require 'lang-python)      ; Python development (disabled)
;; (require 'lang-ruby)        ; Ruby development (disabled)
;; (require 'lang-sql)         ; SQL development (disabled)
;; (require 'lang-swift)       ; Swift development (disabled)

;; Experimental features
(require 'init-treesit)        ; Tree-sitter integration for better syntax highlighting

;; Platform-specific configurations
;; Load appropriate configuration based on the operating system
(cond
 ((eq system-type 'gnu/linux)
  (require 'gnu_linux))         ; Linux-specific settings
 ((eq system-type 'darwin)
  (require 'darwin)))           ; macOS-specific settings (fonts, keybindings, aspell)

;; Legacy system-specific configuration loading (disabled)
;; These would allow per-hostname and per-OS customizations
;; (setq system-specific-config (concat dotfiles-dir system-name ".el"))
;; (if (file-exists-p system-specific-config) (load system-specific-config))
;; (setq os-specific-config (concat dotfiles-dir (prin1-to-string system-type) ".el"))
;; (if (file-exists-p os-specific-config) (load os-specific-config))

;; Start Emacs server for client connections
;; Allows using 'emacsclient' to open files in existing Emacs instance
(require 'server)
(unless (server-running-p)
  (server-start))

(provide 'init)

;;; init.el ends here
