;;; personal-key-chord.el --- Description

;; Copyright (C) 2013 Yu Yang

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

;;; Code:

(require-package 'key-chord)

(require 'key-chord)

;; (key-chord-define-global "jj" 'ace-jump-word-mode)
;; (key-chord-define-global "jl" 'ace-jump-line-mode)
;; (key-chord-define-global "jk" 'ace-jump-char-mode)
(key-chord-define-global "JJ" 'personal-switch-to-previous-buffer)
(key-chord-define-global "uu" 'undo-tree-visualize)
;;(key-chord-define-global "xx" 'execute-extended-command)
(key-chord-define-global "yy" 'browse-kill-ring)

(key-chord-mode +1)

(provide 'personal-key-chord)
;;; personal-key-chord.el ends here
