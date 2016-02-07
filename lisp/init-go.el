;;; go-mode-load.el --- Major mode for the Go programming language

;;; Commentary:

;; To install go-mode, add the following lines to your .emacs file:
;;   (add-to-list 'load-path "PATH CONTAINING go-mode-load.el" t)
;;   (require 'go-mode-load)
;; After this, go-mode will be used for files ending in '.go'.

;; To compile go-mode from the command line, run the following
;;   emacs -batch -f batch-byte-compile go-mode.el

;; See go-mode.el for documentation.

;;; Code:

;; To update this file, evaluate the following form
;;   (let ((generated-autoload-file buffer-file-name)) (update-file-autoloads "go-mode.el"))

;;;### (autoloads (gofmt-before-save gofmt go-mode) "go-mode" "go-mode.el"
;;;;;;  (19917 17808))
;;; Generated autoloads from go-mode.el



;; (autoload 'go-mode "go-mode" "\
;; Major mode for editing Go source text.

;; This provides basic syntax highlighting for keywords, built-ins,
;; functions, and some types.  It also provides indentation that is
;; \(almost) identical to gofmt.

;; \(fn)" t nil)

;; (add-to-list 'auto-mode-alist (cons "\\.go$" #'go-mode))

;; (autoload 'gofmt "go-mode" "\
;; Pipe the current buffer through the external tool `gofmt`.
;; Replace the current buffer on success; display errors on failure.

;; \(fn)" t nil)

;; (autoload 'gofmt-before-save "go-mode" "\
;; Add this to .emacs to run gofmt on the current buffer when saving:
;;  (add-hook 'before-save-hook #'gofmt-before-save)

;; \(fn)" t nil)

;; ;;;***

;; (defun set-exec-path-from-shell-PATH ()
;;   (let ((path-from-shell (replace-regexp-in-string
;;                           "[ \t\n]*$"
;;                           ""
;;                           (shell-command-to-string "$SHELL --login -i -c 'echo $PATH'"))))
;;     (setenv "PATH" path-from-shell)
;;     (setq eshell-path-env path-from-shell) ; for eshell users
;;     (setq exec-path (split-string path-from-shell path-separator))))

;; (when window-system (set-exec-path-from-shell-PATH))

;; ;;go path
;; (setenv "GOPATH" "/Users/carlos/Dev/Go")

;; ;;Automatically call gofmt on save
;; (setq exec-path (cons "/usr/local/go/bin" exec-path))
;; (add-to-list 'exec-path "/Users/carlos/Dev/Go")
;; (add-hook 'before-save-hook 'gofmt-before-save)

;; (defun my-go-mode-hook ()
;;   ; Use goimports instead of go-fmt
;;   (setq gofmt-command "goimports")
;;   ; Call Gofmt before saving
;;   (add-hook 'before-save-hook 'gofmt-before-save)
;;   ; Customize compile command to run go build
;;   (if (not (string-match "go" compile-command))
;;       (set (make-local-variable 'compile-command)
;;            "go build -v && go test -v && go vet"))
;;   ; Godef jump key binding
;;   (local-set-key (kbd "M-.") 'godef-jump))
;; (add-hook 'go-mode-hook 'my-go-mode-hook)


















;; from https://www.youtube.com/watch?v=r6j2W5DZRtA
;; get the following packages ("M-x package-list-packages"):
;;     go-mode
;;     go-eldoc
;;     company-mode
;;     company-go
;; get the following go programs (run each line in your shell):
;;     go get golang.org/x/tools/cmd/godoc
;;     go get golang.org/x/tools/cmd/goimports
;;     go get github.com/rogpeppe/godef
;;     go get github.com/nsf/gocode

(setq company-idle-delay nil)

(setq gofmt-command "goimports")
;; UPDATE: gofmt-before-save is more convenient then having a command
;; for running gofmt manually. In practice, you want to
;; gofmt/goimports every time you save anyways.
(add-hook 'before-save-hook 'gofmt-before-save)

(global-set-key (kbd "C-c M-n") 'company-complete)
(global-set-key (kbd "C-c C-n") 'company-complete)

(defun my-go-mode-hook ()
  ;; UPDATE: I commented the next line out because it isn't needed
  ;; with the gofmt-before-save hook above.
  ;; (local-set-key (kbd "C-c m") 'gofmt)
  (local-set-key (kbd "M-.") 'godef-jump))

(set (make-local-variable 'company-backends) '(company-go))  ;;)

(add-hook 'go-mode-hook 'my-go-mode-hook)
(add-hook 'go-mode-hook 'go-eldoc-setup)
(add-hook 'go-mode-hook 'company-mode)

(provide 'init-go)
