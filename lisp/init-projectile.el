;;; init-projectile.el --- Projectile project management configuration

;;; Commentary:
;;
;; This file configures Projectile, a project interaction library for Emacs.
;; Projectile provides a comprehensive set of features for managing and
;; navigating projects, making it easier to work with multiple codebases
;; and project structures.
;;
;; Key Features:
;; - Automatic project detection (Git, SVN, etc.)
;; - Project-wide file and directory navigation
;; - Project-scoped search and replace operations
;; - Compilation and testing shortcuts within projects
;; - Project switching and management
;; - Integration with version control systems
;;
;; Project Detection:
;; - Git repositories (.git directory)
;; - Other VCS repositories (SVN, Mercurial, etc.)
;; - Build tool markers (Makefile, package.json, etc.)
;; - Manual project file markers (.projectile)
;;
;; Performance:
;; - File caching enabled for faster subsequent operations
;; - Optimized for large codebases and repositories
;; - Indexing of project files for quick access
;;
;; Key Bindings:
;; - s-p: projectile-command-map (super/cmd key + p)
;; - C-c p: projectile-command-map (alternative binding)
;;
;; Common Commands (via prefix):
;; - f: find file in project
;; - s s: search in project (ag/ripgrep)
;; - r: replace in project
;; - c: compile project
;; - t: test project
;; - p: switch project
;;
;; Dependencies:
;; - projectile: Project management library

;;; Code:

(use-package projectile
  :ensure t
  :diminish
  ;;:pin melpa-stable
  :config
  (define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (setq projectile-enable-caching t)
  (projectile-mode +1))

(provide 'init-projectile)

;;; init-projectile.el ends here
