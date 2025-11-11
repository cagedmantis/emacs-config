;;; init-latex.el --- Latex editing copnfiguration

;;; Commentary:

;;; Code:

;; ;; (use-package go-mode
;; ;;   :ensure t)


;; ;Preview TeX/LaTeX output with xdvi and telling it to
;; ; watch the file for changes every 3 seconds
;; (setq tex-dvi-view-command "xdvi -watchfile 3 -expertmode 0")

;; (setq TeX-auto-save t)
;; (setq TeX-parse-self t)
;; (setq TeX-save-query nil)
;; (setq TeX-PDF-mode t)

;; (setq tex-dvi-view-command "xdvi")

;; ====================================================================================================
;; From https://www.stefanom.org/setting-up-a-nice-auctex-environment-on-mac-os-x/
;; ====================================================================================================

;; AucTeX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)

;; Use Skim as viewer, enable source <-> PDF sync
;; make latexmk available via C-c C-c
;; Note: SyncTeX is setup via ~/.latexmkrc (see below)
(add-hook 'LaTeX-mode-hook (lambda ()
                             (push
                              '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
                                :help "Run latexmk on file")
                              TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))

;; use Skim as default pdf viewer
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
      '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))


(use-package tex
  :ensure auctex)

(use-package auctex
  :ensure t)

(use-package lsp-latex
  ;; this uses texlab
  :ensure t
  :config
  (progn
    (add-hook 'bibtex-mode-hook 'lsp)
    )
  )

(provide 'init-latex)
