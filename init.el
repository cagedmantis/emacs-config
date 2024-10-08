;;; init.el --- Emacs configuration init

;;; Commentary:

;;; Code:
(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(add-to-list 'load-path "~/bin/")
(add-to-list 'load-path (concat dotfiles-dir "/lisp"))
(add-to-list 'load-path (concat dotfiles-dir "/system_type"))
(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "packages"))
(setq custom-file (concat dotfiles-dir "custom.el"))

(require 'init-package)

(require 'init-defaults)
(require 'init-appearance)
;;(require 'init-ivy)

;; (require 'init-autoinsert)
;; (require 'init-cc)
;; (require 'init-company)

(require 'init-orderless)
(require 'init-corfu)
(require 'init-vertico)
(require 'init-treemacs)

(require 'init-flycheck)
(require 'init-language-server)
;; (require 'init-latex)
;; (require 'init-magit)
;; (require 'init-org)
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
(require 'lang-rust)
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
