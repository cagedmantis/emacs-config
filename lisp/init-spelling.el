;;; init-spelling.el --- Spell checking configuration  -*- lexical-binding: t; -*-

;;; Commentary:

;; Flyspell, guarded on a spell checker actually being installed.
;;
;; The check is deliberately made when a buffer is opened rather than when
;; this file loads.  On macOS, `exec-path-from-shell' runs from
;; system_type/darwin.el, which init.el loads *after* this module, so at load
;; time a GUI Emacs still has the minimal PATH it inherited from the window
;; manager and would not find a checker in /opt/homebrew/bin.  Deciding at
;; load time would therefore disable spelling in exactly the configuration it
;; is most wanted in.
;;
;; Without a checker, flyspell-mode still *enables* without complaint -- it
;; fails only when it first tries to check a word, with "Searching for
;; program: No such file or directory, ispell".  Guarding avoids that.

;;; Code:

(require 'seq)

(defvar ispell-program-name)          ; defined in ispell.el, loaded on demand

(defcustom init-spelling-programs '("aspell" "hunspell" "ispell")
  "Spell checkers to look for, in order of preference."
  :type '(repeat string)
  :group 'ispell)

(defun init-spelling-program ()
  "Return the first `init-spelling-programs' entry on PATH, or nil."
  (seq-find #'executable-find init-spelling-programs))

(defun init-spelling--ready ()
  "Point ispell at an installed checker.  Return non-nil on success."
  (let ((program (init-spelling-program)))
    (when program
      (require 'ispell)
      (setq ispell-program-name program)
      program)))

;; The two entry points are spelled out rather than funcall\'d through a
;; common helper: `flyspell-mode\' is a real minor mode taking an argument,
;; but `flyspell-prog-mode\' is a plain command of arity (0 . 0).  Passing it
;; the usual 1 signals "Wrong number of arguments: (0 . 0), 1" in every
;; prog-mode buffer.
(defun init-spelling-flyspell ()
  "Enable `flyspell-mode' when a spell checker is installed."
  (when (init-spelling--ready) (flyspell-mode 1)))

(defun init-spelling-flyspell-prog ()
  "Enable `flyspell-prog-mode' when a spell checker is installed."
  (when (init-spelling--ready) (flyspell-prog-mode)))

(use-package flyspell
  :ensure nil  ; built-in
  :hook ((text-mode . init-spelling-flyspell)
	 (org-mode . init-spelling-flyspell)
	 (git-commit-mode . init-spelling-flyspell)
	 (prog-mode . init-spelling-flyspell-prog)))

(use-package flyspell-correct
  :after flyspell
  :ensure t
  :bind (:map flyspell-mode-map ("C-q" . flyspell-correct-wrapper)))

(use-package flyspell-correct-popup
  :after flyspell
  :ensure t)

(provide 'init-spelling)

;;; init-spelling.el ends here
