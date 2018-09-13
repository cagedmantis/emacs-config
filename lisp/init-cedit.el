(use-package cedit
  :ensure t)

; turn on Semantic
(semantic-mode 1)
; let's define a function which adds semantic as a suggestion backend to auto complete
; and hook this function to c-mode-common-hook
(defun my:add-semantic-to-autocomplete() 
  (add-to-list 'ac-sources 'ac-source-semantic)
)
(add-hook 'c-mode-common-hook 'my:add-semantic-to-autocomplete)

; turn on ede mode 
(global-ede-mode 1)

;;https://www.gnu.org/software/emacs/manual/html_node/ede/ede_002dcpp_002droot.html
;; (ede-cpp-root-project "my project" :file "~/demos/my_program/src/main.cpp"
;; 		      :include-path '("/../my_inc"))

; you can use system-include-path for setting up the system header file locations.
; turn on automatic reparsing of open buffers in semantic
(global-semantic-idle-scheduler-mode 1)


;; ----------------------------------------
;; COPIED FROM CONFIG-CEDIT.EL (refactor)
;; ----------------------------------------
;; Cedet
;; (load-file "~/Downloads/cedet-1.0/common/cedet.el")
;; (global-ede-mode t)
;; (semantic-load-enable-excessive-code-helpers)
;; (require 'semantic-ia)
;; (require 'semantic-gcc)
;; (defun my-semantic-hook ()
;;   (imenu-add-to-menubar "TAGS"))
;; (add-hook 'semantic-init-hooks 'my-semantic-hook)
;; (require 'semanticdb)
;; (global-semanticdb-minor-mode 1)
;; ;; if you want to enable support for gnu global
;; (require 'semanticdb-global)
;; (semanticdb-enable-gnu-global-databases 'c-mode)
;; (semanticdb-enable-gnu-global-databases 'c++-mode)

;; ;; enable ctags for some languages:
;; ;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
;; ;;(semantic-load-enable-primary-exuberent-ctags-support)

;; (defun my-c-mode-cedet-hook ()
;;  (local-set-key "." 'semantic-complete-self-insert)
;;  (local-set-key ">" 'semantic-complete-self-insert))
;; (add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

(provide 'init-cedit)
