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
; create a project for our program.

; turn on automatic reparsing of open buffers in semantic
(global-semantic-idle-scheduler-mode 1)

;; highlight the current line
(global-hl-line-mode +1)

(provide 'init-semantic.el)
