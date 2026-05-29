;;; init-project.el --- project.el configuration

;;; Commentary:

;;; Code:

(require 'project)

;; Recognise additional root markers beyond .git / .hg / .svn
(setq project-vc-extra-root-markers '(".project" "go.mod" "Cargo.toml" "package.json"))

;; Keep a persistent list of known projects
(setq project-list-file (concat user-emacs-directory ".cache/projects"))

;; Mirror the old projectile keybindings so muscle memory keeps working
(global-set-key (kbd "C-c p") project-prefix-map)
(global-set-key (kbd "s-p")   project-prefix-map)

(provide 'init-project)

;;; init-project.el ends here
