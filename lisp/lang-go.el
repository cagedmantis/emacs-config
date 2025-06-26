;;; lang-go.el --- Go programming language development configuration

;;; Commentary:
;;
;; This file configures a comprehensive Go development environment for Emacs.
;; It provides intelligent code completion, testing, debugging, and development
;; tools integration through go-mode and LSP (Language Server Protocol).
;;
;; Key Features:
;; - Full LSP integration with gopls (Go language server)
;; - Comprehensive testing support with go-test integration
;; - Code generation and refactoring tools
;; - Import management and formatting
;; - Project-aware development workflow
;;
;; Core Components:
;; - go-mode: Primary Go editing mode
;; - LSP integration: gopls language server support
;; - Testing: gotest package for test execution
;; - Code generation: go-fill-struct, go-add-tags
;; - Error checking: go-errcheck integration
;; - Development tools: Comprehensive Go toolchain
;;
;; Key Bindings:
;; - C-c C-n: go-run (run current file)
;; - C-c .: go-test-current-test (run test at point)
;; - C-c f: go-test-current-file (run tests in file)
;; - C-c a: go-test-current-project (run all project tests)
;; - C-c r: lsp-rename (rename symbol)
;; - C-c j: lsp-find-definition (jump to definition)
;; - C-c d: lsp-describe-thing-at-point (documentation)
;; - C-c ,: lsp-find-references (find references)
;; - C-c i: lsp-find-implementation (find implementation)
;; - C-c t: lsp-find-type-definition (type definition)
;;
;; Development Tools:
;; - Automatic formatting and import organization on save
;; - Struct field generation and tag management
;; - Stack trace analysis with go-stacktracer
;; - Interface implementation generation
;; - Comprehensive error checking
;;
;; Go Tools Installation:
;; - Provides go-install-tools command for tool management
;; - Installs/updates essential Go development tools
;; - Includes gopls, staticcheck, errcheck, and more
;;
;; LSP Features:
;; - Real-time error checking and diagnostics
;; - Code completion with context awareness
;; - Symbol navigation and reference finding
;; - Hover documentation and signature help
;; - Workspace symbol search
;;
;; Dependencies:
;; - go-mode: Core Go editing support
;; - lsp-mode: Language server integration
;; - gotest: Testing framework integration
;; - go-fill-struct: Struct field generation
;; - go-add-tags: Struct tag management
;; - go-errcheck: Error checking tools
;; - go-stacktracer: Stack trace analysis

;;; Code:

;; (use-package go-mode
;;   :ensure t)

(use-package go-mode
  :ensure t
  :bind (:map go-mode-map
			  ("C-c C-n" . go-run)
			  ("C-c ."   . go-test-current-test)
			  ("C-c f"   . go-test-current-file)
			  ("C-c a"   . go-test-current-project)
			  ("C-c r"   . lsp-rename)
			  ("C-c j"   . lsp-find-definition)
			  ("C-c d"   . lsp-describe-thing-at-point)

			  ;; TODO: prove that these are useful
			  ("C-c n" . flymake-goto-next-error)
			  ("C-c p" . flymake-goto-prev-error)
			  ("C-c ," . lsp-find-references)
			  ("C-c i" . lsp-find-implementation)
			  ("C-c t" . lsp-find-type-definition))
  :config
  (add-hook 'go-mode-hook 'lsp-deferred)
  (defun my-go-mode-hook ()
	(subword-mode t)
	(setq tab-width 4)
	;;(add-hook 'before-save-hook 'gofmt-before-save)
	;; (with-eval-after-load 'go-mode
	;;   (go-guru-hl-identifier-mode))

	 (lsp)
	;;(add-hook 'go-mode-hook 'flycheck-mode))
        ;;(add-hook 'go-mode-hook 'flycheck))
         )

  (add-hook 'go-mode-hook 'my-go-mode-hook)
  (add-hook 'go-mode-hook 'lsp-install-save-hooks))
  ;;(add-hook 'before-save-hook #'lsp-go-before-save-hooks))

(use-package go-fill-struct
  :ensure t
  :bind ("C-c f" . go-fill-struct)
  :after go-mode)

(use-package go-errcheck
  :ensure t
  :after go-mode)

;; nis
;; (use-package go-gen-test
;;   :ensure t
;;   :after go-mode)

(use-package gotest
  :ensure t
  :defer t)

(use-package go-stacktracer
  :ensure t
  :after go-mode)

(use-package go-add-tags
  :ensure t
  :after go-mode
  :config
  (global-set-key (kbd "C-c t") 'go-add-tags))

;; nis
;; (use-package go-projectile
;;   :ensure t
;;   :after (go-mode projectile))

(use-package go-impl
  :ensure t
  :after go-mode)

(use-package go-tag
  :ensure t
  :after go-mode)

;; nis
;; (use-package golint
;;   :ensure t)

;; modified from github.com/dougm/go-projectile

(defvar go-tools
  '((asmfmt        . "github.com/klauspost/asmfmt/cmd/asmfmt")
	(fillstruct    . "github.com/davidrjenni/reftools/cmd/fillstruct")
        (stress2       . "github.com/aclements/go-misc/stress2")
        (toolstash     . "golang.org/x/tools/cmd/toolstash")
        (stringer      . "golang.org/x/tools/cmd/stringer")
	(godoc         . "golang.org/x/tools/cmd/godoc")
	(golint        . "golang.org/x/lint/golint")
	(gomodifytags  . "github.com/fatih/gomodifytags")
	(gomvpkg       . "golang.org/x/tools/cmd/gomvpkg")
	(gopls         . "golang.org/x/tools/gopls")
	(gotags        . "github.com/jstemmer/gotags")
	(gotests       . "github.com/cweill/gotests/...")
	(gounconvert   . "github.com/mdempsky/unconvert")
	(impl          . "github.com/josharian/impl")
	(errcheck      . "github.com/kisielk/errcheck")
	(staticcheck   . "honnef.co/go/tools/cmd/staticcheck"))
  "Import paths for My Go tools.")

(defun go-install-toolset ()
  "Install the latest versions of Go related tools via go install."
  (dolist (tool go-tools)
    (let* ((url (cdr tool))
           (cmd (concat "go install " url "@latest"))
           (result (shell-command-to-string cmd)))
      (message "Go tool %s: %s -> %s" (car tool) cmd (string-trim result))))
  (message "Done installing/updating Go Tools"))

(defun go-install-tools ()
  "Update/install Go related tools."
  (interactive)
  (go-install-toolset))

(provide 'lang-go)
;;; lang-go.el ends here
