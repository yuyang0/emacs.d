;;; personal-racket.el --- Description

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

(require-package 'racket-mode)

(defun racket-send-last-sexp-or-region ()
  (interactive)
  (if (use-region-p)
      (racket-send-region (region-beginning) (region-end))
    (racket-send-last-sexp)))
(defun racket-send-definition-or-region ()
  (interactive)
  (if (use-region-p)
      (racket-send-region (region-beginning) (region-end))
    (racket-send-definition)))

(local-set-key (kbd "<f5>") 'racket-send-last-sexp-or-region)
(local-set-key (kbd "<f6>") 'racket-send-definition-or-region)
(local-set-key (kbd "<f7>") 'racket-send-last-sexp)
(add-hook 'racket-mode-hook
          (lambda ()
            (rainbow-delimiters-mode t)
            (enable-paredit-mode)
            ;; eldoc (show the protype of the syntax in minibuffer
            (make-local-variable 'eldoc-documentation-function)
            (setq eldoc-documentation-function 'scheme-get-current-symbol-info)
            (turn-on-eldoc-mode)))
(provide 'personal-racket)
;;; personal-racket.el ends here
