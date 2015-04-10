;; php mode config

(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

(require 'php-mode)
;; (require 'flymake)

;; (defun wicked/php-mode-init ()
;;    "Set some buffer-local variables."
;;    (setq case-fold-search t) 
;;    (setq indent-tabs-mode nil)
;;    (setq fill-column 80)
;;    (setq c-basic-offset 8)
;;    (c-set-offset 'arglist-cont 0)
;;    (c-set-offset 'arglist-intro '+)
;;    (c-set-offset 'case-label 2)
;;    (c-set-offset 'arglist-close 0))
;;  (add-hook 'php-mode-hook 'wicked/php-mode-init)

;; (defun flymake-php-init ()
;;   "Use php to check the syntax of the current file."
;;   (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
;; 	 (local (file-relative-name temp (file-name-directory buffer-file-name))))
;;     (list "php" (list "-f" local "-l"))))


;; (add-to-list 'flymake-err-line-patterns 
;;   '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

;; (add-to-list 'flymake-allowed-file-name-masks '("\\.php$" flymake-php-init))

(setq tab-width 8
      indent-tabs-mode nil)
(setq-default c-basic-offset 8)
;; (setq-default php-mode-force-pear)

(setq-default fill-column 80)
(add-hook 'php-mode-hook 'turn-on-auto-fill)


(add-hook 'php-mode-hook 'my-php-mode-hook)
(defun my-php-mode-hook ()
  "My PHP mode configuration."
  (setq indent-tabs-mode nil
        tab-width 8
        c-basic-offset 8
		fill-column 80))

;; (eval-after-load 'php-mode
;;   add-hook 'php-mode-hook 'my-php-mode-hook)
;; (defun my-php-mode-hook ()
;;   (setq indent-tabs-mode t)
;;   (let ((my-tab-width 8))
;;     (setq tab-width my-tab-width)
;;     (setq c-basic-indent my-tab-width)
;;     (set (make-local-variable 'tab-stop-list)
;;          (number-sequence my-tab-width 200 my-tab-width))))


;; (defun php-enable-wordpress-coding-style ()
;;   "Makes php-mode use coding styles that are preferable for
;; working with Wordpress."
;;   (interactive)
;;   (setq indent-tabs-mode t
;;         fill-column 78
;;         tab-width 4
;;         c-indent-comments-syntactically-p t)
;;   (c-set-style "wordpress")

;;   ;; Undo drupal coding style whitespace effects
;;   (setq show-trailing-whitespace nil)
;;   (remove-hook 'before-save-hook 'delete-trailing-whitespace))

;; (c-add-style
;;   "symfony2"
;;   '("php"
;;     (c-offsets-alist . ((statement-cont . php-lineup-hanging-semicolon)))))


;; ;; Pear coding standards : http://pear.php.net/manual/en/standards.indenting.php
;; (defun pear/php-mode-init ()
;;   "Set some buffer-local variables."
;;   (setq case-fold-search t)
;;   (setq indent-tabs-mode nil)
;;   (setq fill-column 80)
;;   (setq c-basic-offset 8)
;;   (c-set-offset 'arglist-cont 0)
;;   (c-set-offset 'arglist-intro '+)
;;   (c-set-offset 'case-label 2)
;;   (c-set-offset 'arglist-close 0))
;; (add-hook 'php-mode-hook 'pear/php-mode-init)


;; (defun my-php-hook-function ()
;;   (set (make-local-variable 'compile-command) (format "~/bin/php_lint %s" (buffer-file-name))))
;; (add-hook 'php-mode-hook 'my-php-hook-function)


;; (defun flymake-php-init ()
;;   "Use php and phpcs to check the syntax and code compliance of the current file."
;;   (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-inplace))
;;      (local (file-relative-name temp (file-name-directory buffer-file-name))))
;;     (list "php_lint" (list local))))


;; ;;This is the error format for : php -f somefile.php -l 
;; (add-to-list 'flymake-err-line-patterns
;;              '("\(Parse\|Fatal\) error: +\(.?\) in \(.?\) on line \([0-9]+\)$" 3 4 nil 2))


;; (add-to-list 'flymake-allowed-file-name-masks '("\.php$" flymake-php-init))
;; (add-hook 'php-mode-hook (lambda () (flymake-mode 1)))

;;http://www.enigmacurry.com/category/php/

(provide 'config-mode-php)
