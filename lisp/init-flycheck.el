(global-flycheck-mode)
(add-hook 'after-init-hook #'global-flycheck-mode)

(add-hook 'sh-mode-hook 'flycheck-mode)

(require 'flycheck-color-mode-line)

(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))


(with-eval-after-load 'flycheck
  (flycheck-pos-tip-mode))

(eval-after-load 'flycheck
    '(progn
      (set-face-attribute 'flycheck-error nil :foreground "pink")))

(set-face-attribute 'flycheck-warning nil
                   :foreground "yellow"
                    :background "red")

(provide 'init-flycheck)
