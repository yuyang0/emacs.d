;;; personal-yasnippet.el --- Personal yasnippet configuration

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

(require-package 'yasnippet)
(setq yas-snippet-dirs
      `("~/.emacs.d/personal/personal-snippets"
        "~/.emacs.d/personal/built-in-snippets"
;;        "~/.emacs.d/snippets" ;; personal snippets
        ;; the default collection
        ;; ,(concat (sanityinc/directory-of-library "yasnippet") "snippets")
        ))
;; (yas-global-mode +1)

(require 'yasnippet)
(yas-reload-all)
(dolist (hook
         '(c-mode-common-hook php-mode-hook python-mode-hook ruby-mode-hook
                              scheme-mode-hook  sh-mode-hook nxml-mode-hook
                              css-mode-hook js2-mode-hook js3-mode-hook
                              html-mode-hook lisp-mode-hook lua-mode-hook
                              emacs-lisp-mode-hook LaTeX-mode-hook
                              org-mode-hook haskell-mode-hook sql-mode-hook))
  (add-hook hook '(lambda ()
                    (yas-minor-mode))))

;; (add-to-list 'ac-sources 'ac-source-yasnippet)
;; (eval-after-load 'auto-complete
;;   (progn
;;     ))

; (require 'popup)
; ;; key binding of the popup menu in YASnippet
; (define-key popup-menu-keymap (kbd "M-n") 'popup-next)
; (define-key popup-menu-keymap (kbd "TAB") 'popup-next)
; (define-key popup-menu-keymap (kbd "<tab>") 'popup-next)s
; (define-key popup-menu-keymap (kbd "<backtab>") 'popup-previous)
; (define-key popup-menu-keymap (kbd "M-p") 'popup-previous)
; (defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
;   (when (featurep 'popup)
;     (popup-menu*
;      (mapcar
;       (lambda (choice)
;         (popup-make-item
;          (or (and display-fn (funcall display-fn choice))
;              choice)
;          :value choice))
;       choices)
;      :prompt prompt
;      ;; start isearch mode immediately
;      :isearch t
;      )))

; (setq yas-prompt-functions '(yas-popup-isearch-prompt yas-ido-prompt yas-no-prompt))
(provide 'personal-yasnippet)
;;; personal-yasnippet.el ends here
