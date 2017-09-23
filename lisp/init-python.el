;; pip install elpy rope jedi flake8
(use-package elpy
  :ensure t
  :config
  (elpy-enable)
  
  (use-package ein
	:ensure t)

  (use-package py-autopep8
	:ensure t
	:config
	(require 'py-autopep8)
	(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save))
  
  (use-package ein
	:ensure t
	:config
	(elpy-use-ipython))

  ;; flycheck not flymake with elpy
  (when (require 'flycheck nil t)
  	(setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  	(add-hook 'elpy-mode-hook 'flycheck-mode))
  )

(provide 'init-python)
