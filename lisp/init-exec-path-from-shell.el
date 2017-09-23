(require 'exec-path-from-shell)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-copy-env "GOPATH")  
  (exec-path-from-shell-initialize))

(provide 'init-exec-path-from-shell)
