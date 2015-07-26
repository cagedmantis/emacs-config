;; pip install elpy rope jedi

;; Elpy
(elpy-enable)
;; Fixing a key binding bug in elpy
(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
;; Fixing another key binding bug in iedit mode
(define-key global-map (kbd "C-c o") 'iedit-mode)

(setq python-check-command "/usr/local/bin/pyflakes")

(provide 'init-elpy)
