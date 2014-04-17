(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)


(setq org-agenda-files (list "~/Dropbox/work_ps/org/work.org"
                             "~/Dropbox/work_ps/org/school.org" 
                             "~/Dropbox/work_ps/org/home.org"))
