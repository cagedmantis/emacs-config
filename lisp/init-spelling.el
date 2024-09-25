;;; init-spelling.el --- init-spelling configuration

;;; Commentary:

;;; Code:

;; ===========================

(use-package flyspell
  :ensure t
  :hook ((text-mode . flyspell-mode)
	 (org-mode . flyspell-mode)
	 (git-commit-mode . flyspell-mode)
	 (prog-mode . flyspell-prog-mode)))

(use-package flyspell-correct
  :after flyspell
  :ensure t
  :bind (:map flyspell-mode-map ("C-q" . flyspell-correct-wrapper)))

(use-package flyspell-correct-popup
  :after flyspell
  :ensure t)

(provide 'init-spelling)

;;; init-spelling.el ends here
