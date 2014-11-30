;;; personal-company.el --- Description

;; Copyright (C) 2014 Yu Yang

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

(require-package 'company)
(require 'company)

(setq company-idle-delay 0.4)
(setq company-tooltip-limit 10)
(setq company-minimum-prefix-length 2)
;; invert the navigation direction if the the completion popup-isearch-match
;; is displayed on top (happens near the bottom of windows)
(setq company-tooltip-flip-when-above t)
(global-company-mode +1)

(provide 'personal-company)
;;; personal-company.el ends here
