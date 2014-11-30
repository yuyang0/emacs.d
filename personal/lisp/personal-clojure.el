;;; personal-clojure.el --- Description

;; Copyright (C) 2014 Yu Yang

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

(defun clojure-split-window ()
  (when (not (find "*cider-repl*"
                   (mapcar (lambda (w) (buffer-name w))
                           (buffer-list))
                   :test 'equal))
    (error "please start REPL with M-x cider-jack-in."))
  (cond
   ((= 1 (count-windows))
    (delete-other-windows)
    (split-window-vertically (floor (* 0.68 (window-height))))
    (other-window 1)
    (switch-to-buffer "*cider-repl*")
    (other-window 1))
   ((not (find "*cider-repl*"
               (mapcar (lambda (w) (buffer-name (window-buffer w)))
                       (window-list))
               :test 'equal))
    (other-window 1)
    (switch-to-buffer "*cider-repl*")
    (other-window -1))))

(defun clojure-eval-last-sexp-split-window ()
  (interactive)
  (clojure-split-window)
  (if (region-active-p)
      (cider-eval-region (region-beginning) (region-end))
    (cider-eval-last-sexp)))

(defun clojure-eval-defun-split-window ()
  (interactive)
  (clojure-split-window)
  (if (region-active-p)
      (cider-eval-region (region-beginning) (region-end))
    (cider-eval-defun-at-point)))

(after-load 'clojure-mode
  (define-key clojure-mode-map (kbd "<f5>") 'clojure-eval-last-sexp-split-window)
  (define-key clojure-mode-map (kbd "<f6>") 'clojure-eval-defun-split-window)
  (define-key clojure-mode-map (kbd "<f7>") 'clojure-eval-last-sexp-comment-result))

(defun clojure-eval-last-sexp-comment-result ()
  "Print the result of last sexp at next line and then comment the result str."
  (interactive)
  (end-of-line)
  (newline)
  (save-excursion
    (cider-eval-print-last-sexp))
  (insert "; => "))

(provide 'personal-clojure)
;;; personal-clojure.el ends here
