;;; personal-mode.el --- Description

;; Copyright (C) 2013 Yu Yang

;; Time-stamp: <2013-12-18 16:13:39 Wednesday by Yu Yang>
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

(defvar personal-mode-map
  (let ((map (make-sparse-keymap)))
    ;; (define-key map (kbd "C-c o") 'ffap)
    ;; (define-key map (kbd "C-c g") 'personal-google)
    ;; (define-key map (kbd "C-c G") 'personal-github)
    ;; (define-key map (kbd "C-c w") 'personal-wikipedia)

    (define-key map (kbd "C-c u") 'personal-view-url)
    (define-key map (kbd "C-c e") 'personal-eval-and-replace)
    (define-key map (kbd "C-c s") 'personal-swap-windows)
    (define-key map (kbd "C-c S") 'personal-visit-scratch-buffer)
    (define-key map (kbd "C-c t") 'personal-visit-term-buffer)
    (define-key map (kbd "C-c k") 'personal-kill-other-buffers)
    (define-key map (kbd "C-c D") 'delete-this-file)
;;    (define-key map (kbd "C-c p") 'duplicate-line-or-region)

    (define-key map (kbd "C-c r") 'rename-this-file-and-buffer)
    (define-key map (kbd "C-c d") 'sdcv-search)
    (define-key map (kbd "C-c h") 'helm-prelude)

    map)
  "Keymap for personal mode.")

;; define minor mode
(define-minor-mode personal-mode
  "Minor mode to consolidate Emacs personal extensions.

\\{prelude-mode-map}"
  :lighter " Per"
  :keymap personal-mode-map
  )

(define-globalized-minor-mode personal-global-mode personal-mode personal-mode-on)

(defun personal-mode-on ()
  "Turn on `prelude-mode'."
  (personal-mode +1))
(provide 'personal-mode)
;;; personal-mode.el ends here
