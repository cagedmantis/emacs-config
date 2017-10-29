(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-files (list "~/Dropbox/org/work.org"
                             "~/Dropbox/org/school.org" 
                             "~/Dropbox/org/home.org"))

(setq org-treat-S-cursor-todo-selection-as-state-change t)
(setq org-replace-disputed-keys t)

(provide 'init-org)
