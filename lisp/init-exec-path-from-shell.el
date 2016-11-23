(require 'exec-path-from-shell)

(exec-path-from-shell-initialize)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

(provide 'init-exec-path-from-shell)
