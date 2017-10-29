(when (>= emacs-major-version 25)
  (save-place-mode 1))

(when (< emacs-major-version 25)
  (require 'saveplace)
  (setq-default save-place t))

(setq save-place-file (expand-file-name ".places" user-emacs-directory))

(provide 'init-saveplace)
