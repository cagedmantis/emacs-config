;;; init-org.el --- Org Mode configuration and productivity setup

;;; Commentary:
;;
;; This file configures Org Mode, Emacs' powerful document editing, organizing,
;; and planning system. Org Mode provides a comprehensive solution for note-taking,
;; project planning, task management, and document authoring with plain text.
;;
;; Key Features:
;; - Hierarchical document structure with folding
;; - Task management with TODO states and logging
;; - Agenda system for scheduling and deadlines
;; - Project and life organization tools
;; - Integration with Dropbox for cross-device synchronization
;;
;; Directory Structure:
;; - Main directory: ~/Dropbox/Org (cloud synchronized)
;; - Default notes file: ~/org/notes.org (local quick notes)
;; - Agenda files: work.org, school.org, home.org (organized by context)
;;
;; Agenda Configuration:
;; - Multiple agenda files for different life contexts
;; - TODO state changes are logged with timestamps
;; - S-cursor keys for quick TODO state cycling
;; - Integrated with global key bindings for quick access
;;
;; Key Bindings:
;; - C-c l: org-store-link (capture links to current location)
;; - C-c a: org-agenda (open agenda view)
;;
;; Workflow Features:
;; - Cross-device file synchronization via Dropbox
;; - Automatic TODO state logging
;; - Context-based file organization (work/school/home)
;; - Quick link capture and storage
;;
;; Dependencies:
;; - org: Built-in Org Mode (enhanced configuration)
;; - Dropbox or similar cloud sync (for file synchronization)

;;; Code:

(setq org-directory "~/Dropbox/Org")
(setq org-default-notes-file "~/org/notes.org")

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-files (list "~/Dropbox/org/work.org"
                             "~/Dropbox/org/school.org" 
                             "~/Dropbox/org/home.org"))

(setq org-treat-S-cursor-todo-selection-as-state-change t)
(setq org-replace-disputed-keys t)

(provide 'init-org)

;;; init-org.el ends here
