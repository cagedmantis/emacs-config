(use-package flycheck
  :ensure t
  :config
  (global-flycheck-mode)
  (add-hook 'after-init-hook #'global-flycheck-mode)

  (add-hook 'sh-mode-hook 'flycheck-mode)

  (eval-after-load 'flycheck
    '(progn
	   (set-face-attribute 'flycheck-error nil :foreground "pink")))

  (set-face-attribute 'flycheck-warning nil
					  :foreground "yellow"
					  :background "#000099")

  (set-face-attribute 'flycheck-error nil
					  :foreground "red"
					  :background "#000099")


  (use-package flycheck-color-mode-line
	:ensure t
	:config
	(require 'flycheck-color-mode-line)

	(eval-after-load "flycheck"
	  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
	)

  (use-package flycheck-pos-tip
	:ensure t
	:config
	(with-eval-after-load 'flycheck
	  (flycheck-pos-tip-mode))
	)
  )

(provide 'init-flycheck)
