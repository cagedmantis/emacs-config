;; Load erc
(require 'erc)
(require 'tls)


(custom-set-variables
 '(erc-auto-query (quote bury))
 '(erc-autojoin-mode nil)
 '(erc-beep-match-types (quote (current-nick keyword)))
 '(erc-echo-timestamps nil)
 '(erc-fill-mode nil)
 '(erc-insert-timestamp-function (quote erc-insert-timestamp-left))
 '(erc-join-buffer (quote bury))
 '(erc-log-insert-log-on-open nil)
 '(erc-log-mode t)
 '(erc-log-write-after-insert t)
 '(erc-log-write-after-send t)
 '(erc-match-mode t)
 '(erc-max-buffer-size 30000)
 '(erc-modules (quote (button completion irccontrols log match menu netsplit networks noncommands readonly ring scrolltobottom stamp spelling track)))
 '(erc-prompt ">>")
 '(erc-prompt-for-nickserv-password nil)
 ;'(erc-prompt-for-password nil)
 '(erc-query-display (quote buffer))
 '(erc-server-auto-reconnect t)
 '(erc-server-reconnect-attempts 5)
 '(erc-server-reconnect-timeout 3)
 '(erc-services-mode t)
 '(erc-stamp-mode t)
 '(erc-timestamp-format "[%H:%M:%S] ")
 '(erc-timestamp-only-if-changed-flag nil)
 '(erc-track-exclude-types (quote ("JOIN" "KICK" "NICK" "PART" "QUIT" "MODE" "333" "353")))
 '(erc-truncate-buffer-on-save t))

;; Pool of colors to use when coloring IRC nicks.
(setq erc-colors-list '("green" "blue" "red"
			"dark gray" "dark orange"
			"dark magenta" "maroon"
			"indian red" "forest green"
			"midnight blue" "dark violet"))
;; special colors for some people
(setq erc-nick-color-alist '(("John" . "blue")
			     ("Bob" . "red")
			     ))

(defun erc-get-color-for-nick (nick)
  "Gets a color for NICK. If NICK is in erc-nick-color-alist, use that color, else hash the nick and use a random color from the pool"
  (or (cdr (assoc nick erc-nick-color-alist))
      (nth
       (mod (string-to-number
	     (substring (md5 (downcase nick)) 0 6) 16)
	    (length erc-colors-list))
       erc-colors-list)))

(defun erc-put-color-on-nick ()
  "Modifies the color of nicks according to erc-get-color-for-nick"
  (save-excursion
    (goto-char (point-min))
    (while (forward-word 1)
      (setq bounds (bounds-of-thing-at-point 'word))
      (setq word (buffer-substring-no-properties
                  (car bounds) (cdr bounds)))
      (when (or (and (erc-server-buffer-p) (erc-get-server-user word))
                (and erc-channel-users (erc-get-channel-user word)))
        (put-text-property (car bounds) (cdr bounds) 
                           'face (cons 'foreground-color
                                       (erc-get-color-for-nick word)))))))

(add-hook 'erc-mode-hook (lambda ()
                           (modify-syntax-entry ?\_ "w" nil)
                           (modify-syntax-entry ?\- "w" nil)))

(add-hook 'erc-insert-modify-hook 'erc-put-color-on-nick)

;; Set logging location
(setq erc-log-channels-directory "~/.erc/logs/")

;; Save logs on exit or quit
(setq erc-save-buffer-on-part t)

;; Open chat buffers with logged entries
(setq erc-log-insert-log-on-open nil)

;; Save all erc buffers on exit
(defadvice save-buffers-kill-emacs (before save-logs (arg) activate)
(save-some-buffers t (lambda () (when (eq major-mode 'erc-mode) t))))

(provide 'erc-nick-colors)




;; clean

(require 'erc)

(require 'erc-join)
(erc-autojoin-mode t)
(setq erc-autojoin-channels-alist
      '(
        ("freenode.net" "#clojure" "#hackandtell" "#nycpython" "#haskell" "#c++" "#python" "#emacs")
        ))

(require 'erc-lang)

(require 'erc-fill)
(erc-fill-mode t)

;;(setq erc-user-full-name "Carlos Amedee")
;;(setq erc-email-userid "carlos.amedee@gmail.com")

(require 'erc-log)
(setq erc-log-insert-log-on-open nil)
(setq erc-log-channels t)
(setq erc-log-channels-directory "~/.irclogs/")
(setq erc-save-buffer-on-part t)
(setq erc-hide-timestamps nil)

(setq erc-max-buffer-size 20000)

(require 'erc-autoaway)
(setq erc-autoaway-idle-seconds 1200)
(setq erc-autoaway-message "I'm gone (autoaway after %i seconds)")
(setq erc-auto-discard-away t)

(setq erc-auto-query 'buffer)

(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"))

(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))

(require 'erc-services)
(erc-nickserv-mode 1)
;; (setq erc-prompt-for-nickserv-password nil)

(require 'erc-menu)

(defun erc-connect ()
  "Connect to IRC."
  (interactive)
  (progn
    (erc-select :server "irc.freenode.net" :port 6667 :nick "exobit")
    ))

(custom-set-variables
 '(erc-nick "exobit")
 '(erc-nick-uniquifier "_")
 '(erc-prompt-for-password t)
 '(erc-kill-queries-on-quit t)
 '(erc-server-coding-system (quote utf-8))
 )

(provide 'config-erc)
