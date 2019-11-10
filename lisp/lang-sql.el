;;; lang-sql.el --- lang-sql configuration

;;; Commentary:

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
