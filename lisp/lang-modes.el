;;; lang-modes.el --- various language mode configurations

;;; Commentary:

;;; Code:

(use-package protobuf-mode
  :ensure t
  :mode ("\\.proto\\'" . protobuf-mode)
  :config
  (defconst my-protobuf-style
    '((c-basic-offset . 2)
      (indent-tabs-mode . nil)))

  (add-hook 'protobuf-mode-hook
			(lambda () (c-add-style "my-style" my-protobuf-style t))))

(use-package fish-mode
  :ensure t)

(use-package terraform-mode
  :ensure t)

(use-package dockerfile-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

;; (use-package python-mode
;;   :ensure t)

;; (use-package web-mode
;;   :ensure t)

(use-package haskell-mode
  :ensure t)

;; https://jblevins.org/projects/markdown-mode/
(use-package markdown-mode
  :ensure edit-indirect
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package yaml-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))

(use-package flycheck-yamllint
  :ensure t
  :defer t
  :init
  (progn
    (eval-after-load 'flycheck
      '(add-hook 'flycheck-mode-hook 'flycheck-yamllint-setup))))

(use-package smarty-mode
  :defer t)

(use-package sql-indent
  :defer t
  :config
  (eval-after-load 'sql
	'(load-library "sql-indent")))

(provide 'lang-modes)

;;; lang-modes.el ends here
