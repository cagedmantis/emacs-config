;;; lang-cpp.el --- lang-cpp configuration

;;; Commentary:

;;; Code:

;; osx: brew install cmake llvm

(use-package irony
  :ensure t
  :config
  (progn
    ;; If irony server was never installed, install it.
    ;;(unless (irony--find-server-executable) (call-interactively #'irony-install-server))

    (add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode)

    ;; Use compilation database first, clang_complete as fallback.
    (setq-default irony-cdb-compilation-databases '(irony-cdb-libclang
													irony-cdb-clang-complete))

    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
	))

;; I use irony with company to get code completion.
(use-package company-irony
  :ensure t
  :requires company irony
  :config
  (progn
	(eval-after-load 'company '(add-to-list 'company-backends 'company-irony))))

;; I use irony with flycheck to get real-time syntax checking.
(use-package flycheck-irony
  :ensure t
  :requires flycheck irony
  :config
  (progn
	(eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))))

;; Eldoc shows argument list of the function you are currently writing in the echo area.
(use-package irony-eldoc
  :ensure t
  :requires eldoc irony
  :config
  (progn
	(add-hook 'irony-mode-hook #'irony-eldoc)))

(use-package clang-format
  :ensure t
  :config
  (global-set-key (kbd "C-c i") 'clang-format-region)
  (global-set-key (kbd "C-c u") 'clang-format-buffer)

  (setq clang-format-style-option "llvm"))


(provide 'lang-cpp)
;;; lang-cpp.el ends here
