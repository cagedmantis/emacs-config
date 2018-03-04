;;; init-mu.el --- mu43 configuration file

;;; Commentary:

;;; Code:

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu/mu4e")

(use-package mu4e
  :config
  ;; This is a helper to help determine which account context I am in based 
  ;; on the folder in my maildir the email (eg. ~/.mail/nine27) is located in.
  (defun mu4e-message-maildir-matches (msg rx)
    (when rx
      (if (listp rx)
		  ;; If rx is a list, try each one for a match
		  (or (mu4e-message-maildir-matches msg (car rx))
			  (mu4e-message-maildir-matches msg (cdr rx)))
		;; Not a list, check rx
		(string-match rx (mu4e-message-field msg :maildir)))))

  ;; Choose account label to feed msmtp -a option based on From header
  ;; in Message buffer; This function must be added to
  ;; message-send-mail-hook for on-the-fly change of From address before
  ;; sending message since message-send-mail-hook is processed right
  ;; before sending message.
  (defun choose-msmtp-account ()
    (if (message-mail-p)
		(save-excursion
		  (let*
			  ((from (save-restriction
					   (message-narrow-to-headers)
					   (message-fetch-field "from")))
			   (account
				(cond
				 ((string-match "carlos@amedee.net" from) "personal")
				 ((string-match "camedee@digitalocean.com" from) "do"))))
			(setq message-sendmail-extra-arguments (list '"-a" account))))))

  (setq mail-user-agent 'mu4e-user-agent)
  (setq mu4e-mu-binary "/usr/local/bin/mu")
  (setq mu4e-maildir "~/.mail")
  (setq mu4e-get-mail-command "mbsync -a")
  (setq mu4e-update-interval 300)
  (setq mu4e-view-show-images t)
  (setq mu4e-html2text-command "w3m -dump -T text/html")
  ;; This enables unicode chars to be used for things like flags in the message index screens.
  ;; I've disabled it because the font I am using doesn't support this very well. With this
  ;; disabled, regular ascii characters are used instead.
										;(setq mu4e-use-fancy-chars t)
  ;; This enabled the thread like viewing of email similar to gmail's UI.
  (setq mu4e-headers-include-related t)
  (setq mu4e-attachment-dir  "~/Downloads")
  ;; This prevents saving the email to the Sent folder since gmail will do this for us on their end.
  (setq mu4e-sent-messages-behavior 'delete)
  (setq message-kill-buffer-on-exit t)
  ;; Enable inline images.
  (setq mu4e-view-show-images t)
  ;; Use imagemagick, if available.
  (when (fboundp 'imagemagick-register-types)
    (imagemagick-register-types))

  ;; Sometimes html email is just not readable in a text based client, this lets me open the
  ;; email in my browser.
  (add-to-list 'mu4e-view-actions '("View in browser" . mu4e-action-view-in-browser) t)

  ;; Spell checking ftw.
  (add-hook 'mu4e-compose-mode-hook 'flyspell-mode)
  ;; This hook correctly modifies the \Inbox and \Starred flags on email when they are marked.
  ;; Without it refiling (archiving) and flagging (starring) email won't properly result in
  ;; the corresponding gmail action.
  (add-hook 'mu4e-mark-execute-pre-hook
			(lambda (mark msg)
			  (cond ((member mark '(refile trash)) (mu4e-action-retag-message msg "-\\Inbox"))
					((equal mark 'flag) (mu4e-action-retag-message msg "\\Starred"))
					((equal mark 'unflag) (mu4e-action-retag-message msg "-\\Starred")))))

  ;; This sets up my two different context for my personal and work emails.
  (setq mu4e-contexts
		`( ,(make-mu4e-context
			 :name "personal"
			 :enter-func (lambda () (mu4e-message "Switch to the carlos@amedee.net context"))
			 :match-func (lambda (msg)
						   (when msg
							 (mu4e-message-maildir-matches msg "^/carlos_at_amedee_net")))
			 :leave-func (lambda () (mu4e-clear-caches))
			 :vars '((user-mail-address     . "carlos@amedee.net")
					 (user-full-name        . "Carlos Amedee")
					 (mu4e-sent-folder      . "/carlos_at_amedee_net/[Gmail].All Mail")
					 (mu4e-drafts-folder    . "/carlos_at_amedee_net/[Gmail].Drafts")
					 (mu4e-trash-folder     . "/carlos_at_amedee_net/[Gmail].Trash")
					 (mu4e-refile-folder    . "/carlos_at_amedee_net/[Gmail].All Mail")))
		   ,(make-mu4e-context
			 :name "do"
			 :enter-func (lambda () (mu4e-message "Switch to the do context"))
			 :match-func (lambda (msg)
						   (when msg
							 (mu4e-message-maildir-matches msg "^/do")))
			 :leave-func (lambda () (mu4e-clear-caches))
			 :vars '((user-mail-address     . "camedee@digitalocean.com")
					 (user-full-name        . "Carlos Amedee")
					 (mu4e-sent-folder      . "/do/[Gmail].All Mail")
					 (mu4e-drafts-folder    . "/do/[Gmail].Drafts")
					 (mu4e-trash-folder     . "/do/[Gmail].Trash")
					 (mu4e-refile-folder    . "/do/[Gmail].All Mail")))))

  ;; Configure sending mail.
  (setq message-send-mail-function 'message-send-mail-with-sendmail
		sendmail-program "/usr/local/bin/msmtp"
		user-full-name "Carlos Amedee")

  ;; Use the correct account context when sending mail based on the from header.
  (setq message-sendmail-envelope-from 'header)
  (add-hook 'message-send-mail-hook 'choose-msmtp-account)

  ;; Bookmarks for common searches that I use.
  (setq mu4e-bookmarks '(("\\\\Inbox" "Inbox" ?i)
						 ("flag:unread" "Unread messages" ?u)
						 ("date:today..now" "Today's messages" ?t)
						 ("date:7d..now" "Last 7 days" ?w)
						 ("mime:image/*" "Messages with images" ?p))))

(provide 'init-mu)

;;; init-mu.el ends here
