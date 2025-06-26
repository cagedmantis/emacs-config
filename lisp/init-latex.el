;;; init-latex.el --- LaTeX and TeX editing configuration

;;; Commentary:
;;
;; This file configures LaTeX and TeX editing support for Emacs using AUCTeX.
;; It provides comprehensive support for LaTeX document preparation including
;; syntax highlighting, compilation, and document preview.
;;
;; Key Features:
;; - AUCTeX integration for enhanced LaTeX editing
;; - Automatic parsing of LaTeX documents and style files
;; - PDF mode by default for modern LaTeX workflows
;; - Document preview with DVI viewer integration
;; - Automatic save without prompts for smoother workflow
;;
;; Preview Configuration:
;; - xdvi integration with automatic file watching
;; - 3-second refresh interval for live preview
;; - Expert mode disabled for user-friendly interface
;;
;; Document Processing:
;; - PDF mode enabled by default (modern LaTeX standard)
;; - Automatic parsing of document structure
;; - Auto-save functionality for seamless editing
;; - No save prompts to maintain editing flow
;;
;; Dependencies:
;; - auctex: Comprehensive LaTeX editing environment
;; - xdvi: DVI document viewer (for preview)
;; - LaTeX distribution (e.g., TeX Live, MiKTeX)

;;; Code:

;; Preview TeX/LaTeX output with xdvi and telling it to
;; watch the file for changes every 3 seconds
(setq tex-dvi-view-command "xdvi -watchfile 3 -expertmode 0")

(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)

(setq tex-dvi-view-command "xdvi")

(use-package tex
  :ensure auctex)

(provide 'init-latex)
