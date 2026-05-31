;;; init.el --- Emacs configuration init  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(add-to-list 'load-path "~/bin/")
(add-to-list 'load-path (concat user-emacs-directory "/lisp"))
(add-to-list 'load-path (concat user-emacs-directory "/system_type"))
(setq custom-file (concat user-emacs-directory "custom.el"))

(defun init-require (feature)
  "Load FEATURE like `require', but warn and continue rather than abort init.
A single failing module (for example a package missing on one platform)
should not prevent the rest of the configuration from loading."
  (condition-case err
      (require feature)
    (error
     (display-warning 'init
                      (format "Failed to load %s: %s"
                              feature (error-message-string err))
                      :error))))

(init-require 'init-package)

(init-require 'init-defaults)
(init-require 'init-appearance)

;; (require 'init-autoinsert)
;; (require 'init-cc)
;; (require 'init-company)  ; superseded by corfu (init-corfu) for in-buffer completion

(init-require 'init-orderless)
(init-require 'init-corfu)
(init-require 'init-vertico)
(init-require 'init-treemacs)

(init-require 'init-flycheck)
(init-require 'init-language-server)
(init-require 'init-latex)
;; (require 'init-org)

(init-require 'init-project)
;; (require 'init-rainbow-delimiters)
;; (require 'init-saveplace)
;; (require 'init-switch-window)
;; (require 'init-utils)
(init-require 'init-yasnippet)
(init-require 'init-spelling)

(init-require 'init-git)

(init-require 'init-agent)

(init-require 'lang-go)
(init-require 'lang-modes)
(init-require 'lang-cpp)
;; (require 'lang-rust)
;; (require 'lang-javascript)
;; (require 'lang-python)
;; (require 'lang-ruby)
;; (require 'lang-sql)
;; (require 'lang-swift)

;; Experimental
(init-require 'init-treesit)

(cond
 ((eq system-type 'gnu/linux)
  (init-require 'gnu_linux))
 ((eq system-type 'darwin)
  (init-require 'darwin)))

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

;; Load Customize-written settings last so they take final precedence.
(when (and custom-file (file-exists-p custom-file))
  (load custom-file nil t))

(provide 'init)

;;; init.el ends here
