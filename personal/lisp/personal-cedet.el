;;; personal-cedet.el --- Description

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

(require 'semantic)
;; disable semantic in all non C/C++ buffers
(add-to-list 'semantic-inhibit-functions
	     (lambda () (not (member major-mode '(c-mode c++-mode)))))

(setq semantic-default-submodes '(global-semanticdb-minor-mode
                                  global-semantic-idle-scheduler-mode

                                  global-semantic-idle-summary-mode
                                  global-semantic-mru-bookmark-mode))
(add-hook 'c-mode-common-hook
          '(lambda ()
             (semantic-mode +1)))
;;(semantic-mode 1)

;; if you want to enable support for gnu global
;; (when (cedet-gnu-global-version-check t)
;;   (semanticdb-enable-gnu-global-databases 'c-mode)
;;   (semanticdb-enable-gnu-global-databases 'c++-mode))

;;(global-semantic-highlight-edits-mode (if window-system 1 -1))
;;(global-semantic-show-unmatched-syntax-mode 1)
(global-semantic-show-parser-state-mode 1)

(defconst user-include-dirs
  (list ".." "../include" "../inc" "../common" "../public" "../lib" "../core"
        "../src"
        "../.." "../../include" "../../inc" "../../common" "../../public"
        "../../lib" "../../src"))
(defconst linux-include-dirs
  (list "/usr/include"
        "/usr/local/include"))
(let ((include-dirs user-include-dirs))
  (when (eq system-type 'gnu/linux)
    (setq include-dirs (append include-dirs linux-include-dirs)))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))

(defadvice push-mark (around semantic-mru-bookmark activate)
  "Push a mark at LOCATION with NOMSG and ACTIVATE passed to `push-mark'.
If `semantic-mru-bookmark-mode' is active, also push a tag onto
the mru bookmark stack."
  (semantic-mrub-push semantic-mru-bookmark-ring
                      (point)
                      'mark)
  ad-do-it)
(defun semantic-ia-fast-jump-back ()
  (interactive)
  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
      (error "Semantic Bookmark ring is currently empty"))
  (let* ((ring (oref semantic-mru-bookmark-ring ring))
         (alist (semantic-mrub-ring-to-assoc-list ring))
         (first (cdr (car alist))))
    (if (semantic-equivalent-tag-p (oref first tag) (semantic-current-tag))
        (setq first (cdr (car (cdr alist)))))
    (semantic-mrub-switch-tags first)))
(defun semantic-ia-fast-jump-or-back (&optional back)
  (interactive "P")
  (if back
      (semantic-ia-fast-jump-back)
    (semantic-ia-fast-jump (point))))
(define-key semantic-mode-map (kbd "<f12>") 'semantic-ia-fast-jump-or-back)
(define-key semantic-mode-map [C-f12] 'semantic-ia-fast-jump-back)

(provide 'personal-cedet)
;;; personal-cedet.el ends here
