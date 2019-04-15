;;; init-flyspell.el --- init-flyspell configuration

;;; Commentary:

;;; Code:

;; (flycheck-mode)
;; (setq flyspell-issue-welcome-flag nil)
;; (if (eq system-type 'darwin)
;;     (setq-default ispell-program-name "/usr/local/bin/aspell")
;;   (setq-default ispell-program-name "/usr/bin/aspell"))
;; (setq-default ispell-list-command "list")

(use-package flyspell
  :requires ispell flyspell-lazy auto-dictionary
  :config
  ;; NOTE: Automatic spellchecking is disabled because it makes everything terribly slow if the
  ;; files is very long.
  (defun enable-spelling ()
    "Enable spellchecking and automatic dictionary detection."
    (interactive)
    (progn
      (flyspell-lazy-mode)
      (flyspell-mode)
      (auto-dictionary-mode)))

  (defun disable-spelling ()
    (interactive)
    (progn
      (flyspell-lazy-mode -1)
      (flyspell-mode -1)
      (auto-dictionary-mode -1)))

  ;; Flyspell activation for text mode.
  (add-hook 'text-mode-hook (lambda ()
                              (flyspell-lazy-mode)
                              (flyspell-mode)))

  ;; Remove Flyspell from some sub modes of text mode
  (dolist (hook '(change-log-mode-hook
                  log-edit-mode-hook
                  nxml-mode-hook))
    (add-hook hook (lambda ()
                     (flyspell-lazy-mode -1)
                     (flyspell-mode -1))))

  ;; Flyspell comments and strings in programming modes.
  (add-hook 'prog-mode-hook 'flyspell-prog-mode)
  )

;; Improve flyspell responsiveness using idle timers.
(use-package flyspell-lazy
  :ensure t)

;; Tries to automatically detect the language of the buffer and setting the dictionary accordingly.
(use-package auto-dictionary
  :ensure t
  :requires ispell
  :config
  ;;(add-hook 'text-mode-hook 'auto-dictionary-mode)
  )



(provide 'init-flyspell)

;;; init-flyspell.el ends here
