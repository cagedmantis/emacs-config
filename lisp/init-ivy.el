
;;; init-ivy.el --- Ivy completion framework configuration

;;; Commentary:
;;
;; This file configures Ivy, a generic completion mechanism for Emacs.
;; Ivy is a completion framework that provides a clean, minimal interface
;; for various completion tasks. This is a legacy configuration maintained
;; alongside the modern Vertico stack.
;;
;; Key Components:
;; - Ivy: Core completion framework with vertical candidate display
;; - Counsel: Collection of Ivy-enhanced commands (M-x, find-file, etc.)
;; - Swiper: Ivy-based isearch replacement with overview
;; - Ivy-rich: Enhanced candidate annotations with additional information
;; - Various extensions for improved functionality
;;
;; Features:
;; - Virtual buffers integration (recent files, bookmarks)
;; - Fuzzy matching with flx and prescient
;; - Rich annotations showing buffer info, project context
;; - Tramp integration for remote file editing
;; - Spell checking integration
;; - Extensive key bindings for common operations
;;
;; Key Bindings:
;; - C-s: swiper (search in buffer)
;; - M-x: counsel-M-x (enhanced command palette)
;; - C-x C-f: counsel-find-file (enhanced file finder)
;; - C-x b: ivy-switch-buffer (enhanced buffer switcher)
;; - C-c g: counsel-git (search git files)
;; - C-c j: counsel-git-grep (search in git repository)
;; - C-c k: counsel-ag (search with ag/the_silver_searcher)
;;
;; Dependencies:
;; - ivy: Core completion framework
;; - counsel: Ivy-enhanced commands
;; - ivy-rich: Enhanced candidate information
;; - flx: Fuzzy matching algorithm
;; - prescient: Frequency/recency-based candidate sorting
;; - counsel-tramp: Remote server connection support

;;; Code:

(use-package ivy
  :ensure t
  :diminish
  :bind (("C-c C-r" . ivy-resume)
         ("C-x b" . ivy-switch-buffer)
         ("C-x B" . ivy-switch-buffer-other-window))
  :config

  (use-package counsel
	:ensure t
	:diminish counsel-mode
	:bind (("C-x C-f" . counsel-find-file)
           ("M-x" . counsel-M-x)
           ("M-y" . counsel-yank-pop)))

  (use-package ivy-explorer
	:ensure t)

  (ivy-mode 1)

  ;; Add recent files and bookmarks to the ivy-switch-buffer
  (setq ivy-use-virtual-buffers t)

  ;; Displays the current and total number in the collection in the prompt
  (setq ivy-count-format "%d/%d ")

  (setq ivy-height 10)
  (setq ivy-virtual-abbreviate 'full) ; Show the full virtual file paths
  (setq ivy-extra-directories 'nil) ; default value: ("../" "./")
  (setq ivy-wrap t)

  (setq ivy-display-style nil)
  (setq ivy-initial-inputs-alist nil)

  (setq ivy-re-builders-alist
  		'((ivy-switch-buffer . ivy--regex-plus)
  		  (swiper . ivy--regex-plus)
  		  (t . ivy--regex-plus)))


  ;; (setq enable-recursive-minibuffers t)

  (global-set-key (kbd "C-s") 'swiper)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)

  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)

  (global-set-key (kbd "C-c C-r") 'ivy-resume))

(use-package counsel-tramp
  :ensure t
  :after counsel
  :bind ("C-c t" . counsel-tramp)
  :config
  (setq tramp-default-method "ssh"))

(use-package flyspell-correct-ivy
  :ensure t
  :after ivy)

(use-package ivy-rich
  :ensure t
  :init
  (ivy-rich-mode 1)
  :after counsel
  :config
  (setq ivy-format-function #'ivy-format-function-line)
  (setq ivy-rich-display-transformers-list
        (plist-put ivy-rich-display-transformers-list
                   'ivy-switch-buffer
                   '(:columns
                     ((ivy-rich-candidate (:width 40))
                      (ivy-rich-switch-buffer-indicators (:width 4 :face error :align right)); return the buffer indicators
                      (ivy-rich-switch-buffer-major-mode (:width 12 :face warning))          ; return the major mode info
                      (ivy-rich-switch-buffer-project (:width 15 :face success))             ; return project name using `projectile'
                      (ivy-rich-switch-buffer-path (:width (lambda (x) (ivy-rich-switch-buffer-shorten-path x (ivy-rich-minibuffer-width 0.3))))))  ; return file path relative to project root or `default-directory' if project is nil
                     :predicate
                     (lambda (cand)
                       (if-let ((buffer (get-buffer cand)))
                           ;; Don't mess with EXWM buffers
                           (with-current-buffer buffer
                             (not (derived-mode-p 'exwm-mode)))))))))

(use-package flx  ;; Improves sorting for fuzzy-matched results
  :ensure t
  :after ivy
  :defer t
  :init
  (setq ivy-flx-limit 10000)
  (setq ivy-re-builders-alist '((t . ivy--regex-fuzzy))))

(use-package prescient
  :ensure t
  :after counsel
  :config
  (prescient-persist-mode 1))

(use-package ivy-prescient
  :ensure t
  :after prescient
  :config
  (ivy-prescient-mode 1))

(provide 'init-ivy)
;;; init-ivy.el ends here
