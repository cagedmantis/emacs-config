;;; init-git.el --- Git integration and version control configuration

;;; Commentary:
;;
;; This file configures Git integration for Emacs, providing a comprehensive
;; version control workflow with visual feedback and enhanced Git operations.
;;
;; Key Features:
;; - Magit: Full-featured Git porcelain for Emacs
;; - Git gutter: Visual diff indicators in the editor fringe
;; - Git modes: Syntax highlighting for Git configuration files
;; - Auto-refresh status after file saves
;; - Custom diff indicator colors
;;
;; Visual Indicators:
;; - Modified lines: Light golden rod color in gutter
;; - Added lines: Light green color in gutter
;; - Deleted lines: Light coral color in gutter
;;
;; Git File Support:
;; - .gitignore, .gitconfig, .gitattributes syntax highlighting
;; - Proper editing modes for Git configuration files
;;
;; Dependencies:
;; - magit: Comprehensive Git interface
;; - git-modes: Git configuration file modes
;; - git-gutter: Visual diff indicators
;; - diminish: Hide minor mode from modeline

;;; Code:

(use-package magit
  :ensure t
  :config
  (with-eval-after-load 'magit-mode
	(add-hook 'after-save-hook 'magit-after-save-refresh-status t)))

(use-package git-modes
  :ensure t)

;;Show changes in the gutter
(use-package git-gutter
  :ensure t
  :diminish
  :config
  (global-git-gutter-mode 't)
  (set-face-background 'git-gutter:modified 'nil)
  (set-face-foreground 'git-gutter:modified "LightGoldenrod")
  (set-face-foreground 'git-gutter:added "LightGreen")
  (set-face-foreground 'git-gutter:deleted "LightCoral"))

(provide 'init-git)
;;; init-git.el ends here
