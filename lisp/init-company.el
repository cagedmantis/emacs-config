;;; init-company.el --- appearance configuration

;;; Commentary:

;;; Code:

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)

  (setq company-tooltip-align-annotations t)
  (setq company-dabbrev-downcase nil)
  (setq company-tooltip-limit 20)                       ; bigger popup window
  (setq company-idle-delay .25)                         ; decrease delay before autocompletion popup shows
  (setq company-echo-delay 0)                           ; remove annoying blinking
  (setq company-begin-commands '(self-insert-command)) ; start autocompletion only after typing
  (setq company-backends '((company-capf company-dabbrev-code company-etags company-keywords company-yasnippet)
                           (company-files company-dabbrev company-abbrev company-ispell))))

(provide 'init-company)

;;; init-company.el ends here
