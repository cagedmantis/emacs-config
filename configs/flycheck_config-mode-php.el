;; php mode config

(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

(require 'php-mode)

(setq tab-width 8
      indent-tabs-mode nil)
(setq-default c-basic-offset 8)
(setq-default fill-column 80)

;; (add-to-list 'flymake-allowed-file-name-masks '("\.php$" flymake-php-init))
;; (add-hook 'php-mode-hook (lambda () (flymake-mode 1)))

(add-hook 'php-mode-hook 'turn-on-auto-fill)
(add-hook 'php-mode-hook 'my-php-mode-hook)
(defun my-php-mode-hook ()
  "My PHP mode configuration."
  (setq indent-tabs-mode nil
        tab-width 8
        c-basic-offset 8
        fill-column 80))

(provide 'config-mode-php)
