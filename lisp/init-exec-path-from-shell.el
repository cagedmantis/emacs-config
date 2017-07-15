(message "pre exec-path")

(require 'exec-path-from-shell)

(message "Calling exec-path")

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-copy-env "GOPATH")  
  (exec-path-from-shell-initialize))

(message "PATH is now %s" (getenv "PATH"))

(provide 'init-exec-path-from-shell)
