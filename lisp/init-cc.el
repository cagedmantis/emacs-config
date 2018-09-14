;;; init-cc.el --- C configuration init

;;; Commentary:

;;; Code:

(require 'cc-mode)

(setq-default c-basic-offset 4 c-default-style "linux")
(setq-default tab-width 4 indent-tabs-mode t)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

(provide 'init-cc)

;;; init-cc.el ends here
