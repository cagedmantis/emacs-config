;;; init-spelling.el --- init-spelling configuration

;;; Commentary:

;;; Code:

;; ===========================
;; SPELLCHECKING AND THESAURUS


;; TODO: Experimental

;; Spellchecking requires an external command to be available. Install aspell on your Mac, then make it the default checker for Emacs' ispell. Note that personal dictionary is located at ~/.aspell.LANG.pws by default.
(setq ispell-program-name "aspell")


;; Popup window for spellchecking
(use-package flyspell-correct
  :ensure t)
(use-package flyspell-correct-popup
  :ensure t)


;; Enable spellcheck on the fly for all text modes. This includes org, latex and LaTeX.
(add-hook 'text-mode-hook 'flyspell-mode)
(add-hook 'prog-mode-hook 'flyspell-prog-mode)


;; Enable right mouse click on macOS to see the list of suggestions.
(eval-after-load "flyspell"
  '(progn
     (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
     (define-key flyspell-mouse-map [mouse-3] #'undefined)))


;; Spellcheck current word
(define-key flyspell-mode-map (kbd "s-\\") 'flyspell-correct-previous-word-generic) ;; Cmd+\ spellcheck word with popup
(define-key flyspell-mode-map (kbd "C-s-\\") 'ispell-word)                          ;; Ctrl+Cmd+\ spellcheck word using built UI


;; Search for synonyms
(use-package powerthesaurus
  :ensure t
  :config
  (global-set-key (kbd "s-|") 'powerthesaurus-lookup-word-dwim)) ;; Cmd+Shift+\ search thesaurus


;; Word definition search
(use-package define-word
  :ensure t
  :config
  (global-set-key (kbd "M-\\") 'define-word-at-point))

(provide 'init-spelling)

;;; init-spelling.el ends here
