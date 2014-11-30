;;; personal-mew.el --- Description

;; Copyright (C) 2014 Yu Yang

;; Time-stamp: <2013-12-10 21:24:23 Tuesday by Yu Yang>
;;; Author: Yu Yang <yy2012cn@NOSPAM.gmail.com>
;;; URL: https://github.com/yuyang0/emacs.d

;; This file is not part of GNU Emacs.

;; This file is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this file. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;
;;; Code:
; (if (string-equal system-type "windows-nt")
;     ;; Note,in windows,you must use replace stunnel4 with stunnel3 version.
;     (setq mew-prog-ssl  "C:/Program Files/stunnel/stunnel.exe")
;   (setq mew-prog-ssl "/usr/bin/stunnel4"))

; (setq load-path (cons "/usr/local/share/emacs/site-lisp/mew" load-path))
; (autoload 'mew "mew" nil t)
; (autoload 'mew-send "mew" nil t)
; (setq mew-icon-directory "/usr/local/share/emacs/site-lisp/mew/etc")

; ;; Optional setup (Read Mail menu for Emacs 21):
; (if (boundp 'read-mail-command)
;     (setq read-mail-command 'mew))

; ;; Optional setup (e.g. C-xm for sending a message):
; (autoload 'mew-user-agent-compose "mew" nil t)
; (if (boundp 'mail-user-agent)
;     (setq mail-user-agent 'mew-user-agent))
; (if (fboundp 'define-mail-user-agent)
;     (define-mail-user-agent
;       'mew-user-agent
;       'mew-user-agent-compose
;       'mew-draft-send-message
;       'mew-draft-kill
;       'mew-send-hook))

; (setq mew-auto-get t)
; (setq toolbar-mail-reader 'Mew)
; (setq mew-use-cached-passwd t)


(if (string-equal system-type "windows-nt")
    ;; Note,in windows,you must use replace stunnel4 with stunnel3 version.
    (setq mew-prog-ssl  "C:/Program Files/stunnel/stunnel.exe")
  (setq mew-prog-ssl "/usr/bin/stunnel4"))

(setq load-path (cons "/usr/local/share/emacs/site-lisp/mew" load-path))
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)
(setq mew-icon-directory "/usr/local/share/emacs/site-lisp/mew/etc")

(if (boundp 'read-mail-command)
  (setq read-mail-command 'mew))
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
  (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
  (define-mail-user-agent
'mew-user-agent
'mew-user-agent-compose
'mew-draft-send-message
'mew-draft-kill
'mew-send-hook))

(set-default 'mew-decode-quoted 't)
(when (boundp 'utf-translate-cjk)
(setq utf-translate-cjk t)
(custom-set-variables
'(utf-translate-cjk t)))
(if (fboundp 'utf-translate-cjk-mode)
(utf-translate-cjk-mode 1))




(setq mew-fcc "+sent")
(setq mew-demo-picture nil)
(setq mew-pop-size 0)
;;(setq mew-imap-prefix-list '("#mh/" "#mhinbox"))
(setq mew-auto-get t)
(setq toolbar-mail-reader 'Mew)
(setq mew-use-cached-passwd t)
(setq mew-passwd-timer-unit 999)
(setq mew-passwd-lifetime 999)
(set-default 'mew-decode-quoted 't)
(setq mew-prog-pgp "gpg")
(setq mew-pop-delete nil)

(setq mew-config-alist
      '(
        ;; Default fetch mailbox is IMAP
        (default
         (mailbox-type          imap)
         (proto                 "%")
         (imap-server           "imap.gmail.com")
         (imap-user             "yy2012cn@gmail.com")
         (name                  "Yu Yang")
         (user                  "yy2012cn")
         (mail-domain           "gmail.com")
         (imap-ssl      . t)
         (imap-ssl-port . "993")   ;;这条必须得有，可以在gmail设置上查到，不加无法链接上gmail
         (imap-size     . 0)       ;;这两条一定要有.不然无法收邮件,0是不限制收的条数
         (imap-delete . t)         ;;同上
         (smtp-ssl      . t)
         (smtp-ssl-port . "465")   ;;跟993道理一样
         (imap-queue-folder     "%queue")
         (imap-trash-folder     "%Trash") ;; This must be in concile with your IMAP box setup
         (smtp-auth-list        ("PLAIN" "LOGIN" "CRAM-MD5"))
         (smtp-user             "yy2012cn@gmail.com")
         (smtp-server           "smtp.gmail.com"))
))
(setq mew-ssl-verify-level 0)
;;Biff
(setq mew-use-biff t) ;; nil
(setq mew-use-biff-bell t) ;; nil
(setq mew-pop-biff-interval 10) ;; 5 (minutes)

;;Reply
(setq mew-reply-sender-alist
  '(("Reply-To:"
      ("To:" "Reply-To:" "From:"))
    (t
      ("To:" "From:"))))
(setq mew-reply-all-alist
  '((("Followup-To:" "poster")
       ("To:" "From:"))
     ("Followup-To:"
       ("Newsgroups:" "Followup-To:"))
     ("Newsgroups:"
       ("Newsgroups:" "Newsgroups:"))
     ("Reply-To:"
       ("To:" "Reply-To:"))
     (t
       ("To:" "From:")
       ("Cc:" "To:" "Cc:" "Apparently-To:"))))

;;cite
(setq mew-cite-fields '("From:" "Subject:" "Date:" "Message-ID:"))
(setq mew-cite-format "From: %s\nSubject: %s\nDate: %s\nMessage-ID: %s\n\n")
;;(setq mew-cite-prefix-function 'mew-cite-prefix-username)

;;signature
(setq mew-signature-file "~/.signature")
(setq mew-signature-insert-last t)

;;Thread
(setq mew-prog-imls-arg-list '("--thread=yes" "--indent=2"))
(setq mew-use-fancy-thread t)
(setq mew-fancy-thread-indent-strings  [" +" " +" " |" "  "] )
(setq mew-use-thread-separator nil)
(setq mew-thread-separator "--")

;;Sort
(setq mew-sort-default-key-alist
      '(("+inbox" . "date")
        ("+xiyoulinux". "subject")
        ("+zh-kernel". "subject")
        ("+zeuux". "subject")
        ("+lkml" . "subject")))

;;Forward
(setq mew-field-delete-for-forwarding '("Received:" "Return-Path:"))

(provide 'personal-mew)
;;; personal-mew.el ends here
