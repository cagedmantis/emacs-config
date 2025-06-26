;;; lang-modes.el --- Various programming language mode configurations

;;; Commentary:
;;
;; This file configures support for various programming languages and
;; file formats that don't require dedicated configuration files.
;; It provides syntax highlighting, editing modes, and basic tooling
;; for multiple languages and formats.
;;
;; Supported Languages and Formats:
;; - Protocol Buffers (.proto files)
;; - Terraform infrastructure as code (.tf files)
;; - Docker containerization (Dockerfile)
;; - Haskell functional programming (.hs files)
;; - Markdown documentation (.md, .markdown files)
;; - YAML data serialization (.yml, .yaml files)
;; - Bazel build system configuration
;;
;; Protocol Buffers Support:
;; - Syntax highlighting for .proto files
;; - Custom indentation style (2 spaces, tabs for alignment)
;; - Google's Protocol Buffer format support
;;
;; Infrastructure and DevOps:
;; - Terraform: HashiCorp's infrastructure as code
;; - Docker: Container definition and management
;; - Bazel: Google's build and test tool
;;
;; Documentation and Data:
;; - Markdown: GitHub Flavored Markdown for README files
;; - YAML: Configuration files and data serialization
;; - Table of contents generation for Markdown
;;
;; Functional Programming:
;; - Haskell: Pure functional programming language
;; - Basic syntax highlighting and editing support
;;
;; File Associations:
;; - .proto -> protobuf-mode
;; - .tf -> terraform-mode
;; - Dockerfile -> dockerfile-mode
;; - .hs -> haskell-mode
;; - .md, .markdown -> markdown-mode
;; - README.md -> gfm-mode (GitHub Flavored)
;; - .yml, .yaml -> yaml-mode
;;
;; Dependencies:
;; - protobuf-mode: Protocol Buffers support
;; - terraform-mode: Terraform configuration
;; - dockerfile-mode: Docker container definitions
;; - haskell-mode: Haskell programming
;; - markdown-mode: Markdown documentation
;; - markdown-toc: Table of contents generation
;; - yaml-mode: YAML file support
;; - bazel: Bazel build system

;;; Code:

(use-package protobuf-mode
  :ensure t
  :mode ("\\.proto\\'" . protobuf-mode)
  :config
  (defconst my-protobuf-style
    '((c-basic-offset . 2)
      (tab-width . 8)
      (indent-tabs-mode t)))

  (add-hook 'protobuf-mode-hook
	    (lambda () (c-add-style "my-style" my-protobuf-style t)))
  (require 'protobuf-mode))

(use-package terraform-mode
  :ensure t)

(use-package dockerfile-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

(use-package haskell-mode
  :ensure t)

;; https://jblevins.org/projects/markdown-mode/
(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package markdown-toc
  :ensure t)

(use-package yaml-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  (add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode)))

;; (use-package flycheck-yamllint
;;   :ensure t
;;   :defer t
;;   :init
;;   (progn
;;     (eval-after-load 'flycheck
;;       '(add-hook 'flycheck-mode-hook 'flycheck-yamllint-setup))))

(use-package bazel
  :ensure t)

(provide 'lang-modes)

;;; lang-modes.el ends here
