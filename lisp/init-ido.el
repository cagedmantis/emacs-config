;;; init-ido.el --- Flycheck configuration init

;;; Commentary:

;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(when (> emacs-major-version 21)

  (use-package ido
	:ensure t
	:config
	(ido-mode t)
	(ido-everywhere 1)
	(setq ido-enable-prefix nil
		  ido-enable-flex-matching t
		  ido-create-new-buffer 'always
		  ido-use-filename-at-point 'guess
		  ido-max-prospects 10)

	(use-package ido-completing-read+
	  :ensure t
	  :config
	  (ido-ubiquitous-mode 1))

	(use-package ido-vertical-mode
	  :ensure t
	  :config
	  (ido-vertical-mode 1)
	  (setq ido-vertical-define-keys 'C-n-and-C-p-only)
	  (setq ido-vertical-show-count t)

	  (setq ido-use-faces t)
	  (set-face-attribute 'ido-vertical-first-match-face nil
						  :background "#e5b7c0")
	  (set-face-attribute 'ido-vertical-only-match-face nil
						  :background "#e52b50"
						  :foreground "white")
	  (set-face-attribute 'ido-vertical-match-face nil
						  :foreground "#b00000")
	  (ido-vertical-mode 1)
	  )

	(use-package flx-ido
	  :ensure t
	  :config
	  (flx-ido-mode 1)
	  ;; disable ido faces to see flx highlights.
	  (setq ido-enable-flex-matching t)
	  (setq ido-use-faces nil)
	  )
	))
(provide 'init-ido)

;;; init-ido.el ends here
