;;; init-git.el --- git configuration

;;; Commentary:

;;; Code:

(use-package magit
  :ensure t
  :config
  (with-eval-after-load 'magit-mode
	(add-hook 'after-save-hook 'magit-after-save-refresh-status t)))

;;Show changes in the gutter
(use-package git-gutter
  :ensure t
  :diminish
  :config
  (global-git-gutter-mode 't)
  (set-face-background 'git-gutter:modified 'nil)   ;; background color
  (set-face-foreground 'git-gutter:added "green4")
  (set-face-foreground 'git-gutter:deleted "red"))

(provide 'init-git)
;;; init-git.el ends here
