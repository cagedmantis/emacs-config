;;; darwin.el --- macOS specific configuration  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns))
  :config
  (setq exec-path-from-shell-arguments '("-l"))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-envs
   '("GOPATH" "GO111MODULE" "GOPROXY"
     "NPMBIN" "LC_ALL" "LANG" "LC_TYPE"
     "SSH_AGENT_PID" "SSH_AUTH_SOCK" "SHELL")))

(use-package osx-plist
  :ensure t)

;convert fn key on macbook pro to ctl key
(setq ns-function-modifier 'control)
(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)

;; Font selection/sizing is handled cross-platform in init-appearance.el
;; (`set-font'); don't override it here or it clobbers the family + size.

;; TODO: investigate why this config was here.
;; Latex hacks
;; (getenv "PATH")
;; (setenv "PATH"
;; 		(concat
;; 		 "/usr/texbin" ":"
;; 		 (getenv "PATH")))

(setq default-directory "~/")

(defun swap-meta-and-super ()
  "Swap the mapping of meta and super. Very useful for people using their Mac
with a Windows external keyboard from time to time."
  (interactive)
  (if (eq mac-command-modifier 'super)
      (progn
        (setq mac-command-modifier 'meta)
        (setq mac-option-modifier 'super)
        (message "Command is now bound to META and Option is bound to SUPER."))
    (progn
      (setq mac-command-modifier 'super)
      (setq mac-option-modifier 'meta)
      (message "Command is now bound to SUPER and Option is bound to META."))))

(global-set-key (kbd "C-c w") 'swap-meta-and-super)

;; TODO: Investigate what is really needed here.
;;utf-8
(prefer-coding-system 'utf-8)
(when (display-graphic-p)
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

;;utf-8
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(provide 'darwin)

;;; darwin.el ends here
