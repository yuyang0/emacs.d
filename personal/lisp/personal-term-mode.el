;;; personal-term-mode.el --- Description

;; Copyright (C) 2014 Yu Yang

;; Time-stamp: <2013-12-10 21:24:23 Tuesday by Yu Yang>
;;; Author: Yu Yang <yy2012cn@NOSPAM.gmail.com>
;;; URL: https://github.com/yuyang0/

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

;;; Code:

;; @see http://stackoverflow.com/questions/2886184/copy-paste-in-emacs-ansi-term-shell/2886539#2886539
(defun ash-term-hooks ()
  ;; dabbrev-expand in term
  (define-key term-raw-escape-map "/"
    (lambda ()
      (interactive)
      (let ((beg (point)))
        (dabbrev-expand nil)
        (kill-region beg (point)))
      (term-send-raw-string (substring-no-properties (current-kill 0)))))
  ;; yank in term (bound to C-c C-y)
  (define-key term-raw-escape-map "\C-y"
    (lambda ()
      (interactive)
      (term-send-raw-string (current-kill 0))))
  ;; when yasnippet is enabled, disable it. yasnippet will diable the TAB
  ;; completion in ansi-term
  (when (and (boundp 'yas-minor-mode) yas-minor-mode)
      (yas-minor-mode -1)))
(add-hook 'term-mode-hook 'ash-term-hooks)
(setq explicit-shell-file-name "/bin/bash")
;; (if (file-exists-p "/bin/zsh")
;;     (setq explicit-shell-file-name "/bin/zsh")
;;   (setq explicit-shell-file-name "/bin/bash"))

(provide 'personal-term-mode)
;;; personal-term-mode.el ends here
