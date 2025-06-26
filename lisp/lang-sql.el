;;; lang-sql.el --- SQL database development configuration

;;; Commentary:
;;
;; This file configures SQL development support for Emacs, providing
;; code formatting, syntax highlighting, and database interaction
;; capabilities for SQL programming and database management.
;;
;; Key Features:
;; - Automatic SQL code formatting
;; - Format on save functionality
;; - Customizable formatting styles
;; - Integration with SQL mode
;; - Database query formatting
;;
;; Core Components:
;; - sqlformat: SQL code formatting tool
;; - SQL mode integration
;; - Format on save automation
;;
;; Code Formatting:
;; - Automatic formatting with sqlfmt tool
;; - Format on save for consistent code style
;; - Customizable formatting parameters
;; - Support for various SQL dialects
;;
;; Formatting Options (configurable):
;; - Comma-first formatting style
;; - Keyword case conversion (upper/lower)
;; - Identifier case conversion
;; - Indentation width control
;; - Column alignment options
;;
;; Database Support:
;; - Works with all major SQL databases
;; - PostgreSQL, MySQL, SQLite compatibility
;; - Oracle, SQL Server support
;; - Standard SQL formatting
;;
;; Usage:
;; - Automatic formatting on file save
;; - Manual formatting commands available
;; - Integration with SQL development workflow
;; - Consistent code style across projects
;;
;; Setup Requirements:
;; - sqlfmt command-line tool installation
;; - Python-based SQL formatter
;; - pip install sqlfmt (or similar tool)
;;
;; Alternative Tools:
;; - sql-indent: Alternative indentation package
;; - Various SQL formatting backends
;; - Customizable formatter selection
;;
;; Dependencies:
;; - sqlformat: SQL code formatting package
;; - sqlfmt: Command-line SQL formatter tool
;; - sql-mode: Built-in SQL editing mode

;;; Code:

(use-package sqlformat
  :ensure t
  :config
  (add-hook 'sql-mode-hook 'sqlformat-on-save-mode)
  (defvar sqlformat-command "sqlfmt")

  ;; (setq sqlformat-args '("--comma_first" "True"
  ;; 						 "-k" "upper"
  ;; 						 "-i" "lower"
  ;; 						 "-r"
  ;; 						 "--indent_width" "2"
  ;; 						 "--indent_columns"))

  ;;(define-key 'sql-mode-map (kbd "C-c C-f") 'sqlformat)
  )

;; (use-package sql-indent
;;   :ensure t
;;   :config
;;   (eval-after-load 'sql
;; 	'(load-library "sql-indent")))

(provide 'lang-sql)

;;; lang-sql.el ends here
