(use-package rainbow-delimiters
  :ensure t
  :config

  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  (set-face-attribute 'rainbow-delimiters-unmatched-face nil
					  :foreground 'unspecified
					  :inherit 'error)
  )

(provide 'init-rainbow-delimiters)
