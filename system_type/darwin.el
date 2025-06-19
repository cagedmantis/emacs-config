;;; darwin.el --- macOS specific configuration

;;; Commentary:
;;
;; This file contains macOS-specific configurations for Emacs.
;; It handles platform-specific settings that differ from the default
;; cross-platform configuration.
;;
;; Key Areas Covered:
;; - Environment variable setup from shell
;; - Keyboard modifier key remapping (Cmd, Option, Fn keys)
;; - Font configuration with fallbacks
;; - Spell checking integration with aspell
;; - UTF-8 encoding setup
;; - macOS-specific UI tweaks
;;
;; Dependencies:
;; - Requires aspell to be installed via Homebrew at /opt/homebrew/bin/aspell
;; - Uses exec-path-from-shell to inherit shell environment

;;; Code:

;; Environment variable inheritance from shell
;; macOS GUI apps don't inherit shell environment by default
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns))
  :config
  (setq exec-path-from-shell-arguments '("-l"))  ; Use login shell
  (exec-path-from-shell-initialize)
  ;; Copy important environment variables from shell
  (exec-path-from-shell-copy-envs
   '("GOPATH" "GO111MODULE" "GOPROXY"        ; Go development
     "NPMBIN"                                ; Node.js 
     "LC_ALL" "LANG" "LC_TYPE"              ; Locale settings
     "SSH_AGENT_PID" "SSH_AUTH_SOCK"        ; SSH agent
     "SHELL")))                             ; Shell path

;; macOS property list handling utilities  
(use-package osx-plist
  :ensure t)

;; Keyboard modifier key remapping for macOS
;; Makes Emacs key combinations more comfortable on Mac keyboards
(setq ns-function-modifier 'control)    ; Fn key acts as Control
(setq mac-command-modifier 'super)      ; Cmd key acts as Super
(setq mac-option-modifier 'meta)        ; Option key acts as Meta

;; Font configuration for macOS
;; Prefers Source Code Pro but falls back to Monaco if unavailable
(setq preferred-font "Source Code Pro")

;; Utility function to check if a font is available on the system
(defun font-existsp (font)
  "Check if FONT is available on the system."
  (if (window-system)
	  (if (null (x-list-fonts font))
		  nil t)))

;; Set the frame font with fallback
(if (font-existsp preferred-font)
    (set-frame-font preferred-font)
  (set-frame-font "Monaco"))           ; Monaco is always available on macOS

;; Set font size (height is in 1/10pt, so 130 = 13pt)
(set-face-attribute 'default nil :height 130)

;; TODO: investigate why this config was here.
;; Latex hacks
;; (getenv "PATH")
;; (setenv "PATH"
;; 		(concat
;; 		 "/usr/texbin" ":"
;; 		 (getenv "PATH")))

;; Set default directory to user home
(setq default-directory "~/")

;; Utility function for swapping modifier keys
;; Useful when switching between Mac and external Windows keyboards
(defun swap-meta-and-super ()
  "Swap the mapping of meta and super keys.
Very useful for people using their Mac with a Windows external keyboard from time to time."
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

;; Keybinding to toggle modifier key mapping
(global-set-key (kbd "C-c w") 'swap-meta-and-super)

;; Spell checking configuration for macOS
;; Uses aspell installed via Homebrew for better spell checking
(setq ispell-program-name "/opt/homebrew/bin/aspell")  ; Path to aspell binary
(setq ispell-dictionary "american")                   ; Default dictionary
(setq ispell-extra-args '("--sug-mode=ultra"         ; Ultra suggestion mode for better suggestions
                         "--lang=en_US"))             ; Language setting

;; Platform-specific UTF-8 and selection handling
;; Note: Core UTF-8 configuration is handled in init-defaults.el
(prefer-coding-system 'utf-8)
(when (display-graphic-p)
  ;; Set selection request types for proper clipboard handling in GUI mode
  (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))

(provide 'darwin)

;;; darwin.el ends here
