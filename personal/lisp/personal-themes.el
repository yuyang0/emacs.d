;;; personal-themes.el --- Description

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

;; Usage:
;;
;;; Code:

(add-to-list 'custom-theme-load-path *theme-dir*)

;; (require-package 'monokai-theme)
;;; change cursor dynamiclly
;; (require-package 'cursor-chg)
;; (toggle-cursor-type-when-idle 1)

(defun yy-disable-enabled-themes-exclude (excluded-theme)
  (let ((enabled-themes custom-enabled-themes))
    (mapcar (lambda (theme)
              (if (eq theme excluded-theme)
                  nil
                (disable-theme theme)))
            enabled-themes)))

(defun yy-enable-theme (theme)
  (yy-disable-enabled-themes-exclude theme)
  (unless (and (listp custom-enabled-themes)
               (eq theme (car custom-enabled-themes)))
    (load-theme theme t)))

(defun monokai ()
  "enable monokai theme."
  (interactive)
  ;; change cursor color
  (yy-enable-theme 'monokai))
(defun blackboard ()
  "Activate blackboard theme."
  (interactive)
  (yy-enable-theme 'blackboard))
(defun zenburn ()
  "enable zenburn theme."
  (interactive)
  (require-package 'zenburn-theme)
  (yy-enable-theme 'zenburn))

(require-package 'solarized-theme)
(require-package 'color-theme-sanityinc-tomorrow)
;;------------------------------------------------------------------------------
;; Toggle between light and dark
;;------------------------------------------------------------------------------

(defun light ()
  "Activate a light color theme."
  (interactive)
  (yy-enable-theme 'solarized-light))

(defun dark ()
  "Activate a dark color theme."
  (interactive)
  (yy-enable-theme 'solarized-dark))

;;; load theme according time
(defvar night-hour 18
  "When to start with dark theme.")

(defvar day-hour 9
  "When to start with light theme.")

(defun switch-theme-accord-time (light-theme-enable-fun dark-theme-enable-fun)
  "Sets color theme according to current time. Customize `night-hour' and `day-hour'."
  (interactive)
  (let ((hour (nth 2 (decode-time)))
        (minute (nth 1 (decode-time))))
    (if (or (>= hour night-hour) (< hour day-hour) )
        (funcall dark-theme-enable-fun)
      (funcall light-theme-enable-fun))))

;; (switch-theme-accord-time 'light 'monokai)
;; (run-at-time (format "%d:01" day-hour) (* 24 60 60)
;;              'switch-theme-accord-time 'light 'monokai)
;; (run-at-time (format "%d:01" night-hour) (* 24 60 60)
;;              'switch-theme-accord-time 'light 'monokai)
;;(dark)
(monokai)

(provide 'personal-themes)
;;; personal-themes.el ends here
