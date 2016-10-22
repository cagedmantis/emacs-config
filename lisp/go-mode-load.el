;; based on the assumption that the following repos are installed and
;; available on exec-path
;; 
;; - github.com/nsf/gocode
;; - github.com/bradfitz/goimports
;; - github.com/rogpeppe/godef
;; - github.com/golang/lint

(add-hook 'before-save-hook #'gofmt-before-save)
(require 'go-eldoc)
(add-hook 'go-mode-hook 'go-eldoc-setup)

;; setting up autocomplete should happen after yasnippet so we don't duplciate tab bindings.
(require 'auto-complete-config)
(require 'go-autocomplete)
(setq gofmt-command "goimports")






(setq gofmt-command "goimports")


(add-to-list 'auto-mode-alist (cons "\\.go$" #'go-mode))
(setq exec-path (cons "/usr/local/go/bin" exec-path))
(load "$GOPATH/src/code.google.com/p/go.tools/cmd/oracle/oracle.el")

;;(require 'go-mode-load)
(add-hook 'go-mode-hook 'go-oracle-mode)
(add-hook 'go-mode-hook 'go-eldoc-setup)
(add-hook 'before-save-hook 'gofmt-before-save)


(setq gofmt-command "goimports")
;;(add-to-list 'load-path "/home/you/somewhere/emacs/")

;;(add-hook 'before-save-hook 'gofmt-before-save)


;; (defun auto-complete-for-go ()
;; (auto-complete-mode 1))
;; (add-hook 'go-mode-hook 'auto-complete-for-go)

;; (with-eval-after-load 'go-mode
;;    (require 'go-autocomplete))

(provide 'go-mode-load)
