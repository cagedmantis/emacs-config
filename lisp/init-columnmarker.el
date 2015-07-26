(add-to-list 'load-path
	     "~/.emacs.d/plugins/column-marker/")

(require 'column-marker)
(add-hook 'php-mode-hook (lambda () (interactive) (column-marker-1 80)))

(provide 'init-columnmarker)

