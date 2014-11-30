;;; personal-python.el --- Personal python mode settings

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
;;
;;; Code:

(add-hook 'python-mode-hook
          (lambda ()
            (setq python-indent-offset 4)))

(defun python-send-definition-split-window ()
  (interactive)
  (personal-split-window-for-interp "*Python*")
  (if (use-region-p)
      (python-shell-send-region (region-beginning) (region-end))
    (python-shell-send-defun nil)))

(defun python-send-line-split-window ()
  (interactive)
  (personal-split-window-for-interp "*Python*")
  (let ((begin (if (use-region-p)
                   (region-beginning)
                 (line-beginning-position)))
        (end (if (use-region-p)
                 (region-end)
               (line-end-position))))
    (python-shell-send-region begin end)))

(defun python-eval-line-comment-result ()
  "Print the result of last sexp at next line and then comment the result str."
  (interactive)
  (eval-last-exp-comment-result (python-shell-get-or-create-process)
                                'python-send-line-split-window))


(defun python-run-this-file ()
  "run current file"
  (interactive)
  (personal-compile-current-buffer "python"))

(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map (kbd "<f5>") 'python-send-line-split-window)
            (define-key python-mode-map (kbd "<f6>") 'python-send-definition-split-window)
            (define-key python-mode-map (kbd "<f7>") 'python-eval-line-comment-result)

            (define-key python-mode-map (kbd "<C-f5>") 'python-run-this-file)))

;; ----------------------------------------------------------------------------
;; rope(refactor, jump)
;; TO make these settings works well, we must install three python packages:
;; rope, ropemacs and Pymacs
;;
;; 1. sudo pip install rope ropemacs
;; 2. git clone git@github.com:pinard/Pymacs.git
;;    cd Pymacs
;;    make check
;;    sudo make install
;; 3. copy the pymacs.el to the load-path
;; ----------------------------------------------------------------------------
;;(require 'pymacs)
;; Pymacs
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;; (autoload 'pymacs-autoload "pymacs")

;; (pymacs-load "ropemacs" "rope-")
;; (setq ropemacs-enable-autoimport t)
;; (setq ropemacs-guess-project t)

;;----------------------------------------------------------------------------
;;   jedi
;;----------------------------------------------------------------------------
;; (require-package 'jedi)
;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)
;; ----------------------------------------------------------------------------
;; ipython
;;----------------------------------------------------------------------------
(when (file-exists-p "/usr/bin/ipython")
  (setq
   python-shell-interpreter "ipython"
   python-shell-interpreter-args ""
   python-shell-prompt-regexp "In \\[[0-9]+\\]: "
   python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
   python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
   python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
   python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n"))

(provide 'personal-python)
;;; personal-python.el ends here
