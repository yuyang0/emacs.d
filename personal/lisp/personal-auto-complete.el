;;; personal-auto-complete.el --- Personal auto-complete configuration

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
;;
;;; Code:

(require-package 'auto-complete)
(require 'auto-complete-config)
;; (ac-config-default)
(global-auto-complete-mode t)
;;; auto start completion, set nil if you don't want auto popup complete window
(setq ac-auto-start 2)
(setq ac-auto-show-menu t)

;;; "Do What I Mean" function. t means:
;;; After selecting candidates, TAB will behave as RET
;;; TAB will behave as RET only on candidate remains
(setq ac-dwim nil)

(setq ac-candidate-limit ac-menu-height)

;;; quick help(help right the auto-complete window
(setq ac-use-quick-help t)
(setq ac-quick-help-delay .7)

(setq ac-disable-faces nil)

;;; put ac-comphist.dat to temp directory
(setq ac-comphist-file (expand-file-name "ac-comphist.dat" *temp-dir*))
;;----------------------------------------------------------------------------
;; Use Emacs' built-in TAB completion hooks to trigger AC (Emacs >= 23.2)
;;----------------------------------------------------------------------------
(setq tab-always-indent 'complete)  ;; use 't when auto-complete is disabled
(add-to-list 'completion-styles 'initials t)

;; TODO: find solution for php, c++, haskell modes where TAB always does something

;; hook AC into completion-at-point
(defun sanityinc/auto-complete-at-point ()
  (when (and (not (minibufferp))
	     (fboundp 'auto-complete-mode)
	     auto-complete-mode)
    (auto-complete)))

(defun sanityinc/never-indent ()
  (set (make-local-variable 'indent-line-function) (lambda () 'noindent)))

(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions
        (cons 'sanityinc/auto-complete-at-point
              (remove 'sanityinc/auto-complete-at-point completion-at-point-functions))))

(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)

;;; 注意放在前面的有更高的优先级,yasnippet要放在最开始
(setq-default ac-sources
              '(ac-source-yasnippet

                ac-source-abbrev
                ac-source-imenu
                ac-source-dictionary

                ac-source-words-in-buffer
                ac-source-words-in-same-mode-buffers
                ac-source-words-in-all-buffer

                ac-source-files-in-current-dir
                ac-source-filename))

(dolist (mode '(magit-log-edit-mode
                log-edit-mode org-mode text-mode haml-mode
                git-commit-mode
                sass-mode yaml-mode csv-mode espresso-mode haskell-mode
                html-mode nxml-mode sh-mode smarty-mode clojure-mode
                lisp-mode textile-mode markdown-mode tuareg-mode
                js3-mode css-mode less-css-mode sql-mode
                sql-interactive-mode
                inferior-emacs-lisp-mode
                ielm-mode python-mode
                c-mode php-mode ruby-mode cmake-mode LaTeX-mode latex-mode))
  (add-to-list 'ac-modes mode))

;; (set-face-background 'ac-candidate-face "lightgray")
;; (set-face-underline 'ac-candidate-face "darkgray")
;; (set-face-background 'ac-selection-face "steelblue")


;; Exclude very large buffers from dabbrev
(defun sanityinc/dabbrev-friend-buffer (other-buffer)
  (< (buffer-size other-buffer) (* 1 1024 1024)))

(setq dabbrev-friend-buffer-function 'sanityinc/dabbrev-friend-buffer)

;;; fix fly-spell disable auto-complete bug
(when *spell-check-support-enabled*
  (ac-flyspell-workaround))

(define-key ac-completing-map (kbd "M-n") 'ac-next)
(define-key ac-completing-map (kbd "M-p") 'ac-previous)
(define-key ac-completing-map (kbd "TAB") 'ac-expand)
;;; strange problem, RET seems disable by other mode
(define-key ac-completing-map (kbd "RET") 'ac-complete)


(provide 'personal-auto-complete)
;;; personal-auto-complete.el ends here
