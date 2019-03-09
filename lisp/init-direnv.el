;;; init-direnv.el --- init-direnv configuration

;;; Commentary:

;;; Code:

(use-package direnv
  :ensure t
  :demand t
  :config
  (direnv-mode)
  (setq direnv-always-show-summary nil))

(provide 'init-direnv)
;;; init-direnv.el ends here
