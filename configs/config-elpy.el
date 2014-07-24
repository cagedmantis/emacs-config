;; pip install elpy rope jedi

(elpy-enable)
;; Fixing a key binding bug in elpy
(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
;; Fixing another key binding bug in iedit mode
(define-key global-map (kbd "C-c o") 'iedit-mode)

;; Fix problem with path not being set properly
(setq python-check-command "/usr/local/bin/pyflakes")


(provide 'config-elpy)
