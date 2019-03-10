(when (memq window-system '(mac ns x))
  (use-package exec-path-from-shell
	:ensure t
	:after (direnv)
	:config
	(require 'exec-path-from-shell)
	(exec-path-from-shell-initialize)
    (exec-path-from-shell-copy-env "GOPATH")))

(provide 'init-exec-path-from-shell)
