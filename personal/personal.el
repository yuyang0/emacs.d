;;; personal.el --- Description

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

(require 'personal-utils)

;; (require 'personal-company)
;; (require 'personal-web)
;;------------language support-------------
(require 'personal-cc)
(require 'personal-python)
(require 'personal-go)
;; (require 'personal-latex)
(require 'personal-racket)
;; (require 'personal-scheme)
;; (require 'personal-clojure)
;;----------------------------------------------------------------------------
;;  some package settings
;;----------------------------------------------------------------------------
;; (require 'personal-helm)

;; (require 'personal-abbrev)
;; (require 'personal-key-chord)
;; (require 'personal-evil)
;; (require 'personal-term-mode)

;; (require 'personal-mew)
;; (require 'personal-w3m)

;;----------------------------------------------------------------------------
;; personal settings
;;----------------------------------------------------------------------------
;; (require 'personal-font)
(require 'personal-settings)

;; (unless (require 'personal-auto-complete nil t)
;;  (require 'init-auto-complete))
;; (require 'personal-org nil t)
(require 'personal-blog)
;;----------------------------------------------------------------------------
;;  yasnippet must stay behind the config of languages modes
;;----------------------------------------------------------------------------
(require 'personal-yasnippet)

;;; some secret information
;; (require 'secret nil t)


(provide 'personal)
;;; personal.el ends here
