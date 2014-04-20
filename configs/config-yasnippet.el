;; yasnippet

(require 'yasnippet)

(yas-global-mode 1)

(setq yas-snippet-dirs (append yas-snippet-dirs
                               '("~/.emacs.d/modelib/snippets")))

(provide 'config-yasnippet)
