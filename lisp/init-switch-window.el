;;; init-switch-window.el --- switch-window configuration

;;; Commentary:

;;; Code:

(use-package switch-window
  :ensure t
  :config

  (global-set-key (kbd "C-x o") 'switch-window))

(use-package ace-window
  :ensure t
  :config
  (global-set-key (kbd "M-o") 'ace-window)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  )

(provide 'init-switch-window)

;;; init-switch-window.el ends here
