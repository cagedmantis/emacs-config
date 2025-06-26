;;; init-exec-path-from-shell.el --- Shell environment integration for GUI Emacs

;;; Commentary:
;;
;; This file configures exec-path-from-shell to ensure that GUI Emacs
;; inherits the same PATH and environment variables as the user's shell.
;; This is particularly important on macOS and other Unix systems where
;; GUI applications don't inherit shell environment by default.
;;
;; Key Features:
;; - Inherits PATH from shell environment
;; - Copies important environment variables (GOPATH)
;; - Only activates on graphical systems (Mac, X11)
;; - Integrates with direnv for directory-specific environments
;;
;; Environment Variables Copied:
;; - PATH: System executable search path
;; - GOPATH: Go workspace directory
;; - Additional variables can be added as needed
;;
;; Dependencies:
;; - exec-path-from-shell: Environment synchronization package
;; - direnv: Directory-specific environment management (optional)
;;
;; Platform Support:
;; - macOS (ns, mac window systems)
;; - X11 Linux/Unix systems
;; - Terminal Emacs inherits environment naturally (no action needed)

;;; Code:

;; Only configure for GUI environments that need environment inheritance
(when (memq window-system '(mac ns x))
  (use-package exec-path-from-shell
	:ensure t
	:after (direnv)
	:config
	;; Initialize exec-path and environment from shell
	(require 'exec-path-from-shell)
	(exec-path-from-shell-initialize)
	
	;; Copy additional environment variables as needed
    (exec-path-from-shell-copy-env "GOPATH")))

(provide 'init-exec-path-from-shell)

;;; init-exec-path-from-shell.el ends here
