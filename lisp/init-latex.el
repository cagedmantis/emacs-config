;;; init-latex.el --- Latex editing copnfiguration  -*- lexical-binding: t; -*-

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
;; Each file is its own master.  `nil' means "ask", which prompts
;; "Master file (default this file):" on every single .tex visit (and makes
;; .tex files unopenable headlessly).  For a multi-file document, point the
;; child files at the real master with a file-local variable instead --
;; `C-c _' (`TeX-master-file-ask') writes the block for you:
;;     %%% Local Variables:
;;     %%% TeX-master: "main.tex"
;;     %%% End:
(setq-default TeX-master t)
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

;; texlab drives both LaTeX and BibTeX buffers.  Loaded eagerly so the
;; lsp-mode client is registered before any buffer asks for it.
(use-package lsp-latex
  :ensure t)

(declare-function lsp-deferred "lsp-mode")

;; Start texlab only when it is actually installed, so a machine without it
;; opens .tex/.bib files normally instead of prompting to install a server.
;; Same guarded pattern as lang-modes.el / lang-asm.el / lang-wasm.el, and the
;; reason LaTeX is not in the unconditional :hook list in
;; init-language-server.el.
(defun init-latex--maybe-lsp ()
  "Start `lsp-deferred' when the texlab language server is on PATH."
  (when (executable-find "texlab")
    (lsp-deferred)))

(dolist (hook '(LaTeX-mode-hook bibtex-mode-hook))
  (add-hook hook #'init-latex--maybe-lsp))

(provide 'init-latex)

;;; init-latex.el ends here
