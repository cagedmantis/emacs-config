(use-package protobuf-mode
  :ensure t)

(use-package fish-mode
  :ensure t)

(use-package terraform-mode
  :ensure t)

(use-package dockerfile-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

(use-package python-mode
  :ensure t)

(use-package web-mode
  :ensure t)

(use-package js2-mode
  :ensure t)

(use-package haskell-mode
  :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package rust-mode
  :ensure t)

(use-package yaml-mode
  :ensure t
  :config

  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
)

(use-package smarty-mode
  :ensure t)

(use-package sql-indent
  :ensure t
  :config
  (eval-after-load 'sql
	'(load-library "sql-indent")))

(provide 'lang-modes)
