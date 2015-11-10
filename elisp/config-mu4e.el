(require 'mu4e)

(setq mail-user-agent 'mu4e-user-agent)

(setq mu4e-mu-binary "/usr/local/bin/mu")

(setq mu4e-maildir (expand-file-name "~/Maildir")
      mu4e-drafts-folder "/[Gmail].Drafts"
      mu4e-sent-folder "/[Gmail].Sent Mail"
      mu4e-trash-folder "/[Gmail].Trash"
      mu4e-attachment-dir "~/Downloads")

(setq mu4e-sent-messages-behavior 'delete)

(setq mu4e-maildir-shortcuts
      '(("/INBOX" . ?i)
        ("/[Gmail].Sent Mail" . ?s)
        ("/[Gmail].Trash" . ?t)))

(setq mu4e-get-mail-command "offlineimap"
      mu4e-update-interval 120
      mu4e-headers-auto-update t)

(setq
 user-mail-address "adair.david@gmail.com"
 user-full-name "David Adair")

(require 'smtpmail)

(setq message-send-mail-function 'smtpmail-send-it
      starttls-use-gnutls t
      smtpmail-starttls-credentials
      '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials
      (expand-file-name "~/.authinfo.gpg")
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-debug-info t)

(setq mu4e-view-prefer-html t)

(setq mu4e-show-images t)

(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

(defun mu4e-msgv-action-view-in-browser (msg)
  "View the body of the message in a web browser."
  (interactive)
  (let ((html (mu4e-msg-field (mu4e-message-at-point t) :body-html))
        (tmpfile (format "%s/%d.html" temporary-file-directory (random))))
    (unless html (error "No html part for this message"))
    (with-temp-file tmpfile
      (insert
       "<html>"
       "<head><meta http-equiv=\"content-type\""
       "content=\"text/html;charset=UTF-8\">"
       html))
    (browse-url (concat "file://" tmpfile))))

(add-to-list 'mu4e-view-actions
             '("View in browser" . mu4e-msgv-action-view-in-browser) t)

(provide 'config-mu4e)
