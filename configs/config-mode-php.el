;; php mode config

(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

(require 'php-mode)

(setq tab-width 8
      indent-tabs-mode nil)
(setq-default c-basic-offset 8)
;; (setq-default php-mode-force-pear)

(setq-default fill-column 80)
(add-hook 'php-mode-hook 'turn-on-auto-fill)

(add-hook 'php-mode-hook 'my-php-mode-hook)
(defun my-php-mode-hook ()
  "My PHP mode configuration."
  (setq indent-tabs-mode t
        tab-width 8
        c-basic-offset 8
	fill-column 80
	(set (make-local-variable 'show-trailing-whitespace) t)
	c-indent-comments-syntactically-p t))

(setq fci-rule-color "darkblue")
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'php-mode-hook (lambda ()
    (defun ywb-php-lineup-arglist-intro (langelem)
      (save-excursion
        (goto-char (cdr langelem))
        (vector (+ (current-column) c-basic-offset))))
    (defun ywb-php-lineup-arglist-close (langelem)
      (save-excursion
        (goto-char (cdr langelem))
        (vector (current-column))))
    (c-set-offset 'arglist-intro 'ywb-php-lineup-arglist-intro)
    (c-set-offset 'arglist-close 'ywb-php-lineup-arglist-close)))

(provide 'config-mode-php)
