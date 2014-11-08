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

(provide 'init-cedit)
