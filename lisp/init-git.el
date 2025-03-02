;;; init-git.el --- git configuration

;;; Commentary:

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
