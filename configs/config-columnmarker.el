;;; (>>FILE<<) --- 

;; Copyright (C) Carlos Amedee
;;
;; Author: Carlos Amedee <carlos.amedee@gmail.com>
;; Keywords: 
;; Requirements: 
;; Status: not intended to be distributed yet




;;; (>>FILE<<) ends here


;; Column Marker
(add-to-list 'load-path
	     "~/.emacs.d/plugins/column-marker/")

(require 'column-marker)
(add-hook 'php-mode-hook (lambda () (interactive) (column-marker-1 80)))

(provide 'config-columnmarker)
