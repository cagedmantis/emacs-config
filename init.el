;;; init.el --- Emacs configuration init

;;; Commentary:

;;; Code:
(add-to-list 'load-path "~/bin/")
(add-to-list 'load-path (concat user-emacs-directory "/lisp"))
(add-to-list 'load-path (concat user-emacs-directory "/system_type"))
(setq autoload-file (concat user-emacs-directory "loaddefs.el"))
(setq custom-file (concat user-emacs-directory "custom.el"))

(require 'init-package)

(require 'init-defaults)
(require 'init-appearance)
;;(require 'init-ivy)

;; (require 'init-autoinsert)
;; (require 'init-cc)
(require 'init-company)

(require 'init-orderless)
(require 'init-corfu)
(require 'init-vertico)
(require 'init-treemacs)

(require 'init-flycheck)
(require 'init-language-server)
;; (require 'init-latex)
;; (require 'init-org)

;; TODO work to migrate to project.el
(require 'init-projectile)
;; (require 'init-rainbow-delimiters)
;; (require 'init-saveplace)
;; (require 'init-switch-window)
;; (require 'init-utils)
(require 'init-yasnippet)
(require 'init-spelling)

(require 'init-git)

(require 'lang-go)
(require 'lang-modes)
;; (require 'lang-rust)
;; (require 'lang-cpp)
;; (require 'lang-javascript)
;; (require 'lang-python)
;; (require 'lang-ruby)
;; (require 'lang-sql)
;; (require 'lang-swift)

(cond
 ((eq system-type 'gnu/linux)
  (require 'gnu_linux))
 ((eq system-type 'darwin)
  (require 'darwin)))

;; ;system specific configs
;; (setq system-specific-config (concat dotfiles-dir system-name ".el"))
;; (if (file-exists-p system-specific-config) (load system-specific-config))

;; ;os specific configs
;; (setq os-specific-config (concat dotfiles-dir (prin1-to-string system-type) ".el"))
;; (if (file-exists-p os-specific-config) (load os-specific-config))

;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

(provide 'init)

;;; init.el ends here
