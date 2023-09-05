;;; init-flycheck.el --- Flycheck configuration init

;;; Commentary:

;;; Code:

(use-package flycheck
  :ensure t
  :diminish
  :init (global-flycheck-mode)
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  (add-hook 'sh-mode-hook 'flycheck-mode)
  (set-face-attribute 'flycheck-warning nil
        	      :underline `(:style wave :color "yellow")
        	      :foreground "yellow")

  (set-face-attribute 'flycheck-error nil
        	      :underline `(:style wave :color "red")
        	      :foreground "red")

  (set-face-attribute 'flycheck-info nil
        	      :underline `(:style wave :color "green")
        	      :foreground "green")

  (add-to-list 'display-buffer-alist
               `(,(rx bos "*Flycheck errors*" eos)
        	 (display-buffer-reuse-window
        	  display-buffer-in-side-window)
        	 (side            . bottom)
        	 (reusable-frames . visible)
        	 (window-height   . 0.33)))

  ;; (use-package flycheck-color-mode-line
  ;;       :ensure t
  ;;       :config
  ;;       (require 'flycheck-color-mode-line)

  ;;       (eval-after-load "flycheck"
  ;;         '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)))

  (use-package flycheck-pos-tip
    :ensure t
    :config
    (with-eval-after-load 'flycheck
      (flycheck-pos-tip-mode)))
  )

(provide 'init-flycheck)

;;; init-flycheck.el ends here
