;;; init-treesit.el --- Tree-sitter syntax parsing configuration

;;; Commentary:
;;
;; This file configures Tree-sitter language sources for Emacs 29+.
;; Tree-sitter provides fast, incremental parsing for syntax highlighting,
;; indentation, and structural navigation. It offers more accurate and
;; performant syntax analysis compared to traditional regexp-based approaches.
;;
;; Key Features:
;; - Incremental parsing for real-time syntax updates
;; - More accurate syntax highlighting
;; - Better indentation and code structure understanding
;; - Support for modern language features
;; - Extensible grammar system
;;
;; Language Support:
;; - Bash: Shell scripting support
;; - CMake: Build system configuration
;; - CSS: Stylesheet syntax
;; - Elisp: Emacs Lisp (experimental)
;; - Go: Google's Go programming language
;; - HTML: Web markup language
;; - JavaScript/TypeScript: Modern web development
;; - JSON: Data interchange format
;; - Make: Makefile build instructions
;; - Markdown: Documentation and text formatting
;; - Python: Python programming language
;; - TOML: Configuration file format
;; - YAML: Data serialization format
;;
;; Installation:
;; - Grammars are downloaded and compiled automatically
;; - Source repositories are fetched from GitHub
;; - Compiled grammars are cached for performance
;;
;; Performance Benefits:
;; - Faster syntax highlighting for large files
;; - More responsive editing experience
;; - Better accuracy for complex syntax structures
;; - Reduced CPU usage compared to regexp parsing
;;
;; Requirements:
;; - Emacs 29+ with tree-sitter support
;; - C compiler for grammar compilation
;; - Internet connection for grammar downloads
;;
;; Usage:
;; - Modes automatically use tree-sitter when available
;; - Manual installation: M-x treesit-install-language-grammar
;; - Check status: M-x treesit-language-available-p

;;; Code:

;; from https://www.masteringemacs.org/article/how-to-get-started-tree-sitter
(setq treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
        (cmake "https://github.com/uyha/tree-sitter-cmake")
        (css "https://github.com/tree-sitter/tree-sitter-css")
        (elisp "https://github.com/Wilfred/tree-sitter-elisp")
        (go "https://github.com/tree-sitter/tree-sitter-go")
        (html "https://github.com/tree-sitter/tree-sitter-html")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript" "master" "src")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (make "https://github.com/alemuller/tree-sitter-make")
        (markdown "https://github.com/ikatyang/tree-sitter-markdown")
        (python "https://github.com/tree-sitter/tree-sitter-python")
        (toml "https://github.com/tree-sitter/tree-sitter-toml")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
        (yaml "https://github.com/ikatyang/tree-sitter-yaml")))


(provide 'init-treesit)

;;; init-treesit.el ends here
