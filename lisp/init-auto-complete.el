(require 'auto-complete)

(require 'auto-complete-config)
(ac-config-default)

;; gcc -xc++ -E -v -
(defvar include-dirs "/usr/include/x86_64-linux-gnu/c++/4.9")

(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories 'include-dirs))

(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

(provide 'init-auto-complete)
