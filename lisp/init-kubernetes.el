;;; init-kubernetes.el --- kubernetes tools configuration

;;; Commentary:

;;; Code:

(use-package kubernetes
  :ensure t
  :commands (kubernetes-overview))

(use-package kubernetes-tramp
  :ensure t)

(provide 'init-kubernetes)

;;; init-kubernetes.el ends here
