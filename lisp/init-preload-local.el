(defvar *base-dir*
  (expand-file-name (if (boundp 'user-emacs-directory)
                        user-emacs-directory
                      "~/.emacs.d/"))
  "The root dir of this configuration.")
(defvar *personal-preload-file*
  (expand-file-name "personal/preload/personal-preload.el" *base-dir*)
  "This file contains personal settings need to load before other settings")
(defvar *personal-load-file*
  (expand-file-name "personal/personal.el" *base-dir*)
  "This file contains personal settings need to load after other settings")
(defvar *personal-dir* (expand-file-name "personal/" *base-dir*)
  "The dir contains personal configuration which should load after
purcell's configuration.")
(defvar *personal-preload-dir* (expand-file-name "personal/preload/" *base-dir*)
  "This dir contains personal configuration which should load before
purcell's configuration.")
(defvar *vendor-dir* (expand-file-name "personal/vendor/" *base-dir*)
  "This directory houses packages that are not yet available in ELPA (or MELPA).")
(defvar *theme-dir* (expand-file-name "personal/themes/" *base-dir*)
  "This directory houses themes that are not yet available in ELPA (or MELPA).")
(defvar *personal-lisp-dir* (expand-file-name "lisp/" *personal-dir*)
  "This directory contains personal lisp code.")
(defvar *savefile-dir* (expand-file-name "savefile/" *base-dir*)
  "This directory contains saved files.")
(defvar *temp-dir* (expand-file-name "temp/" *base-dir*)
  "This directory contains temp files.")

(unless (file-exists-p *savefile-dir*)
  (make-directory *savefile-dir*))

(unless (file-exists-p *temp-dir*)
  (make-directory *temp-dir*))

(defun add-subfolders-to-load-path (parent-dir)
 "Add all level PARENT-DIR subdirs to the `load-path'."
 (dolist (f (directory-files parent-dir))
   (let ((name (expand-file-name f parent-dir)))
     (when (and (file-directory-p name)
                (not (equal f ".."))
                (not (equal f "."))
                (not (equal f ".git"))
                (not (equal f ".hg"))
                (not (equal f ".ropeproject")))
       (add-to-list 'load-path name)
       (add-subfolders-to-load-path name)))))

(add-to-list 'load-path *personal-lisp-dir*)
(add-to-list 'load-path *personal-dir*)
(add-to-list 'load-path *personal-preload-dir*)
(add-to-list 'load-path *vendor-dir*)
(add-subfolders-to-load-path *vendor-dir*)


(when (file-exists-p *personal-preload-file*)
 (load *personal-preload-file*))

(provide 'init-preload-local)