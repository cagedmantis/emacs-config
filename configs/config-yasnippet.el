;; yasnippet
;; (add-to-list 'load-path
;; 	     "~/.emacs.d/plugins/yasnippet-0.6.1c")

;; (require 'yasnippet)
;; (yas/initialize)

(yas/load-directory "~/.emacs.d/modelib/snippets")

;; (add-to-list yas-snippet-dirs
;;               "~/.emacs.d/plugins/yasnippet-0.6.1c/snippets") 

;; (setq yas-snippet-dirs (append yas-snippet-dirs
;;                                '("~/.emacs.d/modelib/snippets")))

(provide 'config-yasnippet)
