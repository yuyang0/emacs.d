;;; backup.el --- Description

;; Copyright (C) 2014 Yu Yang

;; Time-stamp: <2013-12-10 21:24:23 Tuesday by Yu Yang>
;;; Author: Yu Yang <yy2012cn@NOSPAM.gmail.com>
;;; URL: https://github.com/yuyang0/
;;; Version: 0.1
;;; Package-Requires: ((package-name "version"))

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

;; Installation:

;; ELPA packages are available on Marmalade and Melpa. Alternatively, place
;; this file on a directory in your `load-path', and explicitly require it.

;; Usage:
;;
;;; Code:

;;--------如果已选中区域则kill区域，否则kill n整行，------
(defun call-with-region (origin-func region-func &rest args)
  "if region is active call region-func with region-beginning and region-end as its arguments,
   otherwith call origin-func with args as its arguments"
  (if (region-active-p)
      (let ((begin (region-beginning))
            (end (region-end)))
        (if (= begin end)
            (apply origin-func args)
          (funcall region-func begin end)))
    (apply origin-func args)))

(defun yy-kill-line-or-region(arg)
  "this function is a wrapper of (kill-line).
   When called interactively with no active region, this function
  will call (kill-line) ,else kill the region."
  (interactive "p")
  (call-with-region 'kill-line 'kill-region arg))

(global-set-key (kbd "C-k") 'yy-kill-line-or-region)
;;; -------------------------------------------------------------------
;;;          paredit kill line or region
;;; -------------------------------------------------------------------
(defun yy-paredit-kill-line-or-region(arg)
  "this function is a wrapper of (paredit-kill-line).
   When called interactively with no active region, this function
  will call (paredit-kill) ,else kill the region."
  (interactive "P")
  (call-with-region 'paredit-kill 'paredit-kill-region arg))

(defun yy-paredit-del-forward-char-or-region (n)
  (interactive "p")
  (call-with-region 'paredit-forward-delete 'paredit-delete-region n))
(defun yy-paredit-del-backward-char-or-region (n)
  (interactive "p")
  (call-with-region 'paredit-backward-delete 'paredit-delete-region n))

(eval-after-load "paredit"
  '(progn
     (define-key paredit-mode-map (kbd "C-k") 'yy-paredit-kill-line-or-region)
     (define-key paredit-mode-map (kbd "C-d") 'yy-paredit-del-forward-char-or-region)
     (define-key paredit-mode-map (kbd "<delete>") 'yy-paredit-del-forward-char-or-region)
     (define-key paredit-mode-map (kbd "<backspace>") 'yy-paredit-del-backward-char-or-region)
;;     (define-key paredit-mode-map (kbd "C-o") 'paredit-open-line)
     )
  )

(defun yy-org-kill-line-or-region(arg)
  (interactive "p")
  (call-with-region 'org-kill-line 'kill-region arg))
(eval-after-load "org"
  '(progn
     (define-key org-mode-map (kbd "C-k") 'yy-org-kill-line-or-region)))
;;-------------------------------------------------------------------
;;--------给backspace，C-d，delete添加delete-region功能----------------
(global-set-key (kbd "C-d") 'delete-forward-char)
(unless delete-active-region
  (setq delete-active-region t))
;;--------------------------------------------------------------------
;;    给upcase downcase capitalize添加region
;;--------------------------------------------------------------------
(defun yy-upcase-word-or-region(&optional arg)
  (interactive "p")
  (call-with-region 'upcase-word 'upcase-region arg))

(defun yy-downcase-word-or-region(&optional arg)
  (interactive "p")
  (call-with-region 'downcase-word 'downcase-region arg))

(defun yy-capitalize-word-or-region(&optional arg)
  (interactive "p")
  (call-with-region 'capitalize-word 'capitalize-region arg))

(global-set-key (kbd "C-x C-u") 'yy-upcase-word-or-region)
(global-set-key (kbd "M-u") 'yy-upcase-word-or-region)
(global-set-key (kbd "C-x C-l") 'yy-downcase-word-or-region)
(global-set-key (kbd "M-l") 'yy-downcase-word-or-region)
(global-set-key (kbd "M-c") 'yy-capitalize-word-or-region)



(defun paredit-open-line-below ()
  (interactive)
  (let ((current-point (point))
        (line-end (line-end-position))
        (sexp-end (save-excursion
                    (beginning-of-line)
                    (forward-sexp)
                    (point))))
    (if (and (< sexp-end line-end)
             (>= sexp-end current-point))
        (goto-char sexp-end)
      (goto-char line-end))
    (newline-and-indent)))
(defun paredit-open-line (&optional abovep)
  (interactive "P")
  (if abovep
      (vi-open-line-above)
    (paredit-open-line-below)))

(defvar major-hook-compile-command-alist
  '((sh-mode-hook . "bash")
    (python-mode-hook . "python")
    (ruby-mode-hook . "ruby")
    (perl-mode-hook . "perl")))
(dolist (entry major-hook-compile-command-alist)
  (lexical-let ((hook (car entry))
                (command (cdr entry)))
    (add-hook hook
              (lambda ()
                (local-set-key (kbd "<f5>")
                               (lambda ()
                                 (interactive)
                                 (yy-compile-current-buffer-with-command command)))))))

;;-------C-o:新行并对齐，类似于vi的o命令
(defun vi-open-line-below()
  (interactive)
  (unless (eolp)
    (end-of-line))
  (newline-and-indent))
(defun vi-open-line-above()
  (interactive)
  (unless(bolp)
    (beginning-of-line))
  (newline)
  (forward-line -1)
  (indent-according-to-mode))
(defun vi-open-line(&optional abovep)
  (interactive "P")
  (if abovep
      (vi-open-line-above)
    (vi-open-line-below)))


(setq org-publish-project-alist
      '(
        ("blog-notes"
         :base-directory "~/Documents/note/"
         :base-extension "org"
         :publishing-directory "~/Documents/blog/"
         :recursive t
         ;;         :publishing-function org-publish-org-to-html
         :publishing-function org-html-publish-to-html
         ;;         :link-home "index.html"
         ;;         :link-up "sitemap.html"
         ;; :html-link-home "index.html"
         ;; :html-link-up "sitemap.html"
         :headline-levels 5
         :section-numbers nil
         :auto-preamble t
         :auto-sitemap t                ; Generate sitemap.org automagically...
         :sitemap-filename "sitemap.org"  ; ... call it sitemap.org (it's the default)...
         :sitemap-title "Sitemap"         ; ... with title 'Sitemap'.
         :author "Yu Yang"
         :email "yy2012cn@gmail.com"
         ;;         :style    "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/main.css\"/>"
         :html-head  "<link rel=\"stylesheet\" type=\"text/css\" href=\"/static/css/main.css\"/> <link rel=\"shortcut icon\" href=\"/static/img/favicon.ico\" />"
         :html-preamble t
         :html-postamble nil
         )
        ("blog-static"
         :base-directory "~/Documents/note/"
         :base-extension "css\\|js\\|pdf\\|png\\|jpg\\|gif\\|mp3\\|ogg\\|swf\\|ico"
         :publishing-directory "~/Documents/blog/"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("blog" :components ("blog-notes" "blog-static"))
        ;;
        ))

;; (defadvice org-publish
;;   (after my-org-publish-project-advice activate)
;;   "advice org-publish-project to run a script to generate rss and sitemap"
;;   (let* ((proj (ad-get-arg 0))
;;          (project-alist  (if (not (stringp proj))
;;                              (list proj)
;;                            (list (assoc proj org-publish-project-alist))))
;;          (projects (org-publish-expand-projects project-alist)))
;;     (mapc (lambda (proj)
;;             (let ((pub-dir (plist-get (cdr proj) :publishing-directory))
;;                   (base-dir (plist-get (cdr proj) :base-directory))
;;                   (pub-func (plist-get (cdr proj) :publishing-function)))
;;               (when (equal pub-func 'org-html-publish-to-html)
;;                 (run-tool-script base-dir pub-dir))))
;;           projects)))
;; (defun run-tool-script (base-dir pub-dir)
;;   "run the tool script in base directory"
;;   (let ((exec-script (car (personal-findr "main.py" base-dir))))
;;     (when exec-script
;;       (shell-command (concat "python " exec-script " " base-dir " " pub-dir "&")))))

(provide 'backup)
;;; backup.el ends here
