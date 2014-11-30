;;; personal-abbrev.el --- Description

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

(define-abbrev-table 'python-mode-abbrev-table
  '(
    ("isettings" "from django.conf import settings")
    ("iuser" "
try:
    from django.contrib.auth import get_user_model
    User = get_user_model()
except ImportError:
    from django.contrib.auth.models import User
")
    ("irequestcontext" "from django.template import RequestContext")
    ("imodel" "from django.db import models")
    ("iform" "from django import forms")
    ))


(define-abbrev-table 'global-abbrev-table
  '(
    ;; english abbrevation
    ("8asap" "as soon as possible")
    ("8btw" "by the way")
    ("8aka" "also know as")
    ("8bf" "boyfriend")
    ("8gf" "girlfriend")
    ("8wtf" "what the fuck")
    ("8wysiwyg" "what you see is what you get")

    ;; math/unicode symbols
    ("8in" "∈")
    ("8nin" "∉")
    ("8subset" "⊆")
    ("8empty" "∅")
    ("8union" "∪")
    ("8inter" "∩")
    ("8exist" "∃")
    ("8every" "∀")
    ("8iff" "⇔")
    ("8inf" "∞")
    ("8luv" "♥")
    ("8smly" "☺")

    ("8leftarrow" "⟵")
    ("8rightarrow" "⟶")
    ("8alpha" "α")
    ("8beta" "β")
    ("8gamma" "γ")
    ("8theta" "θ")
    ("8lambda" "λ")
    ("8eta" "η")
    ;; email
    ("8me" "yy2012cn@gmail.com")

    ;; computing tech
    ("8wp" "Wikipedia")
    ("8ms" "Microsoft")
    ("8g" "Google")
    ("8it" "IntelliType")
    ("8msw" "Microsoft Windows")
    ("8win" "Windows")
    ("8ie" "Internet Explorer")
    ("8ahk" "AutoHotkey")

    ;; normal english words
    ("8alt" "alternative")
    ("8char" "character")
    ("8def" "definition")
    ("8bg" "background")
    ("8kb" "keyboard")
    ("8ex" "example")
    ("8kbd" "keybinding")
    ("8env" "environment")
    ("8var" "variable")
    ("8ev" "environment variable")
    ("8cp" "computer")

    ;; book name abbrevations
    ("8csapp" "Computer Systems: A Programmer's Perspective(Randal E. Bryant and David R. O'Hallaron, CMU)")
    ("8ita" "Introduction to Algorithms")
    ("8apue" "Advanced Programming in the UNIX Environment(W. Richard Stevens)")
    ("8unp" "UNIX Network Programming(W. Richard Stevens)")
    ("8paip" "Paradigms of Artificial Intelligence Programming(Peter Norvig)")
    ("8sicp" "Structure and Interpretation of Computer Programs(Gerald Jay Sussman)")
    ("8eopl" "Essentials of Programming Languages(Daniel P. Friedman)")
    ("8tls" "The Little Schemer(Daniel P. Friedman)")
    ("8tss" "The Seasoned Schemer(Daniel P. Friedman)")
    ("8trs" "The Reasoned Schemer(Daniel P. Friedman)")
    ("8alj" "A Little Java, A Few Patterns.(Daniel P. Friedman)")

    ;; emacs regex
    ("8d" "\\([0-9]+?\\)")
    ("8str" "\\([^\"]+?\\)\"")

    ))

;; stop asking whether to save newly added abbrev when quitting emacs
(setq save-abbrevs nil)

;; turn on abbrev mode globally
(setq-default abbrev-mode t)


(provide 'personal-abbrev)
;;; personal-abbrev.el ends here
