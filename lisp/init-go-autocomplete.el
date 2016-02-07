(require 'go-autocomplete)

(require 'auto-complete-config)
(ac-config-default)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

(provide 'init-go-autocomplete)
