;Preview TeX/LaTeX output with xdvi and telling it to
; watch the file for changes every 3 seconds
(setq tex-dvi-view-command "xdvi -watchfile 3 -expertmode 0")

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)

(setq tex-dvi-view-command "xdvi")

(use-package tex
  :ensure auctex)

(provide 'init-latex)
