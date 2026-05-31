;;; lang-modes.el --- various language mode configurations  -*- lexical-binding: t; -*-

;;; Commentary:
;; Lightweight major modes for assorted file types (infra, markup, build,
;; config).  Each declares its file associations with `:mode' so the package
;; is loaded lazily on first use.  LSP is not forced on here -- run `M-x lsp'
;; in a buffer if the matching language server is installed (terraform-ls,
;; yaml-language-server, vscode-json-languageserver, cmake-language-server …).

;;; Code:

(use-package protobuf-mode
  :ensure t
  :mode "\\.proto\\'"
  :config
  (defconst lang-modes--protobuf-style
    '((c-basic-offset . 2)
      (tab-width . 8)
      (indent-tabs-mode . t))
    "C style used for Protocol Buffers buffers.")
  (defun lang-modes--protobuf-setup ()
    (c-add-style "protobuf" lang-modes--protobuf-style t))
  (add-hook 'protobuf-mode-hook #'lang-modes--protobuf-setup))

(use-package terraform-mode
  :ensure t
  :mode ("\\.tf\\'" "\\.tfvars\\'")
  :hook (terraform-mode . terraform-format-on-save-mode))

(use-package dockerfile-mode
  :ensure t
  :mode ("Dockerfile\\'" "\\.dockerfile\\'"))

(use-package haskell-mode
  :ensure t
  :hook (haskell-mode . interactive-haskell-mode))

;; https://jblevins.org/projects/markdown-mode/
(use-package markdown-mode
  :ensure t
  ;; Order matters: use-package prepends these to `auto-mode-alist' in list
  ;; order, so the most specific pattern (README) must come last to win.
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)
         ("README\\.md\\'" . gfm-mode))
  :init
  ;; Prefer pandoc, fall back to multimarkdown, then plain markdown.
  (setq markdown-command (or (executable-find "pandoc")
                             (executable-find "multimarkdown")
                             "markdown")))

(use-package markdown-toc
  :ensure t
  :after markdown-mode)

(use-package yaml-mode
  :ensure t
  :mode "\\.ya?ml\\'")

(use-package json-mode
  :ensure t
  :mode "\\.json\\'")

(use-package toml-mode
  :ensure t
  :mode "\\.toml\\'")

(use-package cmake-mode
  :ensure t
  :mode (("CMakeLists\\.txt\\'" . cmake-mode)
         ("\\.cmake\\'" . cmake-mode)))

(use-package bazel
  :ensure t)

;; Auto-start LSP for these modes, but only when the matching language server
;; is actually on PATH -- so opening one of these files never prompts or errors
;; on a machine that lacks the server.  Install a server to enable it:
;;   terraform-ls, yaml-language-server, vscode-json-language-server,
;;   docker-langserver (dockerfile-language-server-nodejs), cmake-language-server.
;; The binary names below match what lsp-mode's clients launch.
(declare-function lsp-deferred "lsp-mode")

(defun lang-modes--lsp-when-server (&rest servers)
  "Start `lsp-deferred' in the current buffer if any of SERVERS is on PATH."
  (when (seq-some #'executable-find servers)
    (lsp-deferred)))

(dolist (entry '((terraform-mode-hook "terraform-ls" "terraform-lsp")
                 (yaml-mode-hook       "yaml-language-server")
                 (json-mode-hook       "vscode-json-language-server" "vscode-json-languageserver")
                 (dockerfile-mode-hook "docker-langserver")
                 (cmake-mode-hook      "cmake-language-server")))
  (let ((servers (cdr entry)))
    (add-hook (car entry)
              (lambda () (apply #'lang-modes--lsp-when-server servers)))))

(provide 'lang-modes)
;;; lang-modes.el ends here
