(require 'go-autocomplete)

(require 'auto-complete-config)
(ac-config-default)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

(add-hook 'go-mode-hook
          (lambda ()
            (go-eldoc-setup)
            (add-hook 'before-save-hook 'gofmt-before-save)))


(with-eval-after-load 'go-mode
   (require 'go-autocomplete))
(provide 'init-go-autocomplete)
