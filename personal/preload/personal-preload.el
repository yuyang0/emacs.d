;;; personal-preload.el --- Description
;; Time-stamp: <2013-12-18 10:26:34 Wednesday by Yu Yang>
;;; Author: Yu Yang <yy2012cn@NOSPAM.gmail.com>
;;; URL: https://github.com/yuyang0/emacs.d

;;;
;;; Commentary:
;; Usage:
;;
;;; Code:
(unless (boundp 'require-packages)
  (defun require-packages (package-lst)
    (if (listp package-lst)
        (mapc 'require-package package-lst)
      (require-package package-lst))))

(setq Info-additional-directory-list
      '("~/.emacs.d/personal/info-files/" "~/.info"))

;; (unless (require 'personal-themes nil t)
;;   (require 'init-themes))

;;; for init-ido, get over compile log issue
(defvar ido-cur-item nil)
(defvar ido-default-item nil)
(defvar ido-cur-list nil)
(defvar ido-context-switch-command nil)

(provide 'personal-preload)
;;; personal-preload.el ends here
