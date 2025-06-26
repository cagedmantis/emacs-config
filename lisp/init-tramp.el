;;; init-tramp.el --- TRAMP remote file editing configuration

;;; Commentary:
;;
;; This file configures TRAMP (Transparent Remote Access, Multiple Protocol),
;; Emacs' built-in package for editing files on remote systems. TRAMP allows
;; seamless editing of files over various protocols (SSH, SCP, FTP, etc.) as
;; if they were local files.
;;
;; Key Features:
;; - Transparent remote file access through Emacs file operations
;; - Multiple protocol support (SSH, SCP, SFTP, FTP, etc.)
;; - Integration with all Emacs file operations and modes
;; - Persistent connection management for efficiency
;; - Backup handling for remote files
;;
;; File Access Syntax:
;; - SSH: /ssh:user@host:/path/to/file
;; - SCP: /scp:user@host:/path/to/file
;; - Sudo: /sudo::/path/to/file (local root access)
;; - Multi-hop: /ssh:user@host|sudo::/path/to/file
;;
;; Configuration Details:
;; - Backup directory inheritance from local settings
;; - Disabled backup creation for remote files (performance)
;; - Custom persistency file location (~/.tramp)
;; - Auto-save mode disabled for remote files (avoids conflicts)
;;
;; Performance Optimizations:
;; - Connection reuse and caching
;; - Reduced backup operations
;; - Streamlined file transfer protocols
;;
;; Security Considerations:
;; - Uses system SSH configuration and keys
;; - Respects authentication methods (key-based, password)
;; - Connection information cached securely
;;
;; Dependencies:
;; - tramp: Built-in remote file access
;; - SSH client (for SSH-based connections)
;; - Various protocol handlers as needed

;;; Code:

(use-package tramp
  :ensure t
  :config
  (require 'tramp nil t)

  (setq tramp-backup-directory-alist backup-directory-alist)
  (setq tramp-backup-directory-alist nil)
  (setq tramp-persistency-file-name "~/.tramp")

  (defun tramp-set-auto-save ()
	(auto-save-mode -1)))

(provide 'init-tramp)

;;; init-tramp.el ends here
