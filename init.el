;;; init.el --- Emacs configuration init

;;; Commentary:

;;; Code:

;;(package-initialize)

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "Emacs ready in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done)))

(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(add-to-list 'load-path "~/bin/")
(add-to-list 'load-path (concat dotfiles-dir "/config"))
(add-to-list 'load-path (concat dotfiles-dir "/lisp"))
(add-to-list 'load-path (concat dotfiles-dir "/system_type"))
(setq autoload-file (concat dotfiles-dir "loaddefs.el"))
(setq package-user-dir (concat dotfiles-dir "packages"))
(setq custom-file (concat dotfiles-dir "custom.el"))

(require 'init-package)

(require 'defaults)
(require 'appearance)
(require 'init-ivy)

(require 'init-autoinsert)
(require 'init-cc)
(require 'init-columnmarker)
(require 'init-company)
;;(require 'init-direnv)
(require 'init-erc)
(require 'init-exec-path-from-shell)
(require 'init-flycheck)
;;(require 'init-flyspell)
(require 'init-language-server)
(require 'init-latex)
(require 'init-magit)
(require 'init-org)
(require 'init-plantuml)
(require 'init-projectile)
(require 'init-rainbow-delimiters)
(require 'init-saveplace)
(require 'init-sudo-save)
(require 'init-switch-window)
(require 'init-utils)
(require 'init-yasnippet)
;;(require 'init-iedit)
;;(require 'init-spelling)

(require 'lang-cpp)
(require 'lang-go)
(require 'lang-javascript)
(require 'lang-modes)
(require 'lang-python)
(require 'lang-ruby)
(require 'lang-rust)
(require 'lang-sql)
(require 'lang-swift)

(cond
 ((eq system-type 'gnu/linux)
  (require 'gnu_linux))
 ((eq system-type 'darwin)
  (require 'darwin)))

;system specific configs
(setq system-specific-config (concat dotfiles-dir system-name ".el"))
(if (file-exists-p system-specific-config) (load system-specific-config))

;os specific configs
(setq os-specific-config (concat dotfiles-dir (prin1-to-string system-type) ".el"))
(if (file-exists-p os-specific-config) (load os-specific-config))

;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))

(provide 'init)

;;; init.el ends here
