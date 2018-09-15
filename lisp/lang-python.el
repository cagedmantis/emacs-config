;;; lang-python.el --- Python configuration

;;; Commentary:

;;; Code:

(use-package elpy
  :ensure t
  :config
  (elpy-enable)

  (use-package pyenv-mode
	:ensure t)

  (use-package py-autopep8
	:ensure t
	:config
	(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save))

  (when (require 'flycheck nil t)
  	(setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  	(add-hook 'elpy-mode-hook 'flycheck-mode)))

;; TODO: pip install elpy rope jedi flake8

(provide 'lang-python)

;;; lang-python.el ends here
