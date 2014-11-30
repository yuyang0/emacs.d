;;; personal-scheme.el --- Description

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

;;
;;; Code:

(require 'cmuscheme)
;; (setq auto-mode-alist
;;       (append '(("\\.rkt\\'" . scheme-mode))
;;               auto-mode-alist))

(setq scheme-program-name "racket")
;; bypass the interactive question and start the default interpreter
(defun scheme-proc ()
  "Return the current Scheme process, starting one if necessary."
  (unless (and scheme-buffer
               (get-buffer scheme-buffer)
               (comint-check-proc scheme-buffer))
    (save-window-excursion
      (run-scheme scheme-program-name)))
  (or (scheme-get-process)
      (error "No current process. See variable `scheme-buffer'")))


(defun scheme-split-window ()
  (cond
   ((= 1 (count-windows))
    (delete-other-windows)
    (split-window-vertically (floor (* 0.68 (window-height))))
    (other-window 1)
    (switch-to-buffer "*scheme*")
    (other-window 1))
   ((not (find "*scheme*"
               (mapcar (lambda (w) (buffer-name (window-buffer w)))
                       (window-list))
               :test 'equal))
    (other-window 1)
    (switch-to-buffer "*scheme*")
    (other-window -1))))


(defun scheme-send-last-sexp-split-window ()
  (interactive)
  ;;(scheme-split-window)
  (personal-split-window-for-interp "*scheme*")
  (if (use-region-p)
      (scheme-send-region (region-beginning) (region-end))
    (scheme-send-last-sexp)))


(defun scheme-send-definition-split-window ()
  (interactive)
  ;;  (scheme-split-window)
  (personal-split-window-for-interp "*scheme*")
  (if (use-region-p)
      (scheme-send-region (region-beginning) (region-end))
    (scheme-send-definition)))


(defun scheme-eval-last-sexp-comment-result ()
  "Print the result of last sexp at next line and then comment the result str."
  (interactive)
  (eval-last-exp-comment-result (scheme-proc)
                                'scheme-send-last-sexp-split-window
                                1))

(defun scheme-run-this-file ()
  (interactive)
  (personal-compile-current-buffer scheme-program-name))

(add-hook 'scheme-mode-hook
          (lambda ()
            (paredit-mode 1)
            (define-key scheme-mode-map (kbd "<f5>") 'scheme-send-last-sexp-split-window)
            (define-key scheme-mode-map (kbd "<f6>") 'scheme-send-definition-split-window)
            (define-key scheme-mode-map (kbd "<f7>") 'scheme-eval-last-sexp-comment-result)

            (define-key scheme-mode-map (kbd "<C-f5>") 'scheme-run-this-file)))

;;; enable paredit in inferior mode
(add-hook 'inferior-scheme-mode-hook
          (lambda ()
            ;; enable paredit makes the process can't write the output
            ;;(paredit-mode +1)
            (rainbow-delimiters-mode +1)))

(require-package 'scheme-complete)
(require 'scheme-complete)
;; (eval-after-load 'scheme
;;   '(define-key scheme-mode-map "\e\t" 'scheme-smart-complete))
(defun my-scheme-hook ()
  (rainbow-delimiters-mode t)
  (enable-paredit-mode)
  ;; eldoc for scheme-mode(show the protype of the syntax in minibuffer
  (make-local-variable 'eldoc-documentation-function)
  (setq eldoc-documentation-function 'scheme-get-current-symbol-info)
  (turn-on-eldoc-mode))
(add-hook 'scheme-mode-hook 'my-scheme-hook)


(provide 'personal-scheme)
;;; personal-scheme.el ends here
