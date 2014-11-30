;;; personl-octave.el --- Description

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

(require 'octave)

(setq octave-send-show-buffer t)

(defun octave-send-line-split-window ()
  (interactive)
  (if (use-region-p)
      (octave-send-region (region-beginning) (region-end))
    (octave-send-line)))
(defun octave-send-definition-split-window ()
  (interactive)
  (if (use-region-p)
      (octave-send-region (region-beginning) (region-end))
    (octave-send-defun)))

(defun octave-run-this-file ()
  (interactive)
  (personal-compile-current-buffer inferior-octave-program))

(add-hook 'octave-mode-hook
          (lambda ()
            (define-key octave-mode-map (kbd "<f5>")
              'octave-send-line-split-window)
            (define-key octave-mode-map (kbd "<f6>")
              'octave-send-definition-split-window)
            (define-key octave-mode-map (kbd "<f7>")
              'octave-eval-line-comment-result)

            (define-key octave-mode-map (kbd "<C-f5>")
              'octave-eval-print-last-sexp)))

(provide 'personl-octave)
;;; personl-octave.el ends here
