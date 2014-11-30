;;; personal-helm.el --- Description
;; Time-stamp: <2013-12-12 12:36:50 Thursday by Yu Yang>
;;; Author: Yu Yang <yy2012cn@NOSPAM.gmail.com>
;;; URL: https://github.com/yuyang0/emacs.d

;;;
;;; Commentary: some basic config for helm
;; Usage:
;;  (require 'init-helm)
;;; Code:

(require-package 'helm)

(require-package 'helm-projectile)
(require 'helm-misc)
(require 'helm-projectile)

(defun helm-prelude ()
  "Preconfigured `helm'."
  (interactive)
  (condition-case nil
      (if (projectile-project-root)
          (helm-projectile)
        ;; otherwise fallback to `helm-mini'
        (helm-mini))
    ;; fall back to helm mini if an error occurs (usually in `projectile-project-root')
    (error (helm-mini))))

(global-set-key (kbd "C-c h")  'helm-prelude)

(provide 'personal-helm)
;;; personal-helm.el ends here
