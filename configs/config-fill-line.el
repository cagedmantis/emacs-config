(require 'fill-column-indicator)

(setq fci-rule-width 1)
(setq fci-rule-color "darkblue")

(add-hook 'php-mode-hook 'fci-mode)
(provide 'config-fill-line)
