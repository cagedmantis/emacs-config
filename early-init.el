;;; early-init.el --- Early initialization -*- lexical-binding: t -*-

;;; Commentary:

;;; Code:

;; Defer GC during startup; restored to a sane value in init-defaults.el
(setq gc-cons-threshold most-positive-fixnum)

;; Suppress UI elements before the frame renders to avoid flicker.
;; init-appearance.el also disables these, but by then it's too late.
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)

;; package.el initialization is handled explicitly in init-package.el
(setq package-enable-at-startup nil)

(provide 'early-init)

;;; early-init.el ends here
