;;; personal-org.el --- Personal org-mode settings

;; Copyright (C) 2014 Yu Yang

;; Time-stamp: <2013-12-10 21:24:23 Tuesday by Yu Yang>
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

;;---------------------------------------------------------
;;       pdf export Chinese support
;;---------------------------------------------------------
;; (require 'ox-latex)
;; ;; Add minted to the defaults packages to include when exporting.
;; (add-to-list 'org-latex-packages-alist '("" "minted"))
;; ;; Tell the latex export to use the minted package for source
;; ;; code coloration.
;; (setq org-latex-listings 'minted)
;; ;; Let the exporter use the -shell-escape option to let latex
;; ;; execute external programs.
;; ;; This obviously and can be dangerous to activate!
;; (setq org-latex-pdf-process
;;       '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

;; (setq org-latex-pdf-process '("xelatex -interaction nonstopmode %f"
;;                               "xelatex -interaction nonstopmode %f"))
(require 'personal-org-latex)
(setq org-html-mathjax-options '(
                                 ;;(path "http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML")
                                 (path "http://cdn.bootcss.com/mathjax/2.4.0/MathJax.js?config=TeX-AMS-MML_HTMLorMML")
                                 (scale "100")
                                 (align "center")
                                 (indent "2em")
                                 (mathml t)))
;;; add the offline version mathjax.js to the template.(used the skill when load the jquery)
(setq org-html-mathjax-template
      "<script type=\"text/javascript\" src=\"%PATH\"></script>\n
<script type=\"text/javascript\">window.MathJax || document.write('<script src=\"static/js/mathjax/MathJax.js?config=TeX-AMS-MML_HTMLorMML\" ><\\/script>')</script>\n<script type=\"text/javascript\">\n
<!--/*--><![CDATA[/*><!--*/\n    MathJax.Hub.Config({\n        // Only one of the two following lines, depending on user settings\n        // First allows browser-native MathML display, second forces HTML/CSS\n        :MMLYES: config: [\"MMLorHTML.js\"], jax: [\"input/TeX\"],\n        :MMLNO: jax: [\"input/TeX\", \"output/HTML-CSS\"],\n        extensions: [\"tex2jax.js\",\"TeX/AMSmath.js\",\"TeX/AMSsymbols.js\",\n                     \"TeX/noUndefined.js\"],\n        tex2jax: {\n            inlineMath: [ [\"\\\\(\",\"\\\\)\"] ],\n            displayMath: [ ['$$','$$'], [\"\\\\[\",\"\\\\]\"], [\"\\\\begin{displaymath}\",\"\\\\end{displaymath}\"] ],\n            skipTags: [\"script\",\"noscript\",\"style\",\"textarea\",\"pre\",\"code\"],\n            ignoreClass: \"tex2jax_ignore\",\n            processEscapes: false,\n            processEnvironments: true,\n            preview: \"TeX\"\n        },\n        showProcessingMessages: true,\n        displayAlign: \"%ALIGN\",\n        displayIndent: \"%INDENT\",\n\n        \"HTML-CSS\": {\n             scale: %SCALE,\n             availableFonts: [\"STIX\",\"TeX\"],\n             preferredFont: \"TeX\",\n             webFont: \"TeX\",\n             imageFont: \"TeX\",\n             showMathMenu: true,\n        },\n        MMLorHTML: {\n             prefer: {\n                 MSIE:    \"MML\",\n                 Firefox: \"MML\",\n                 Opera:   \"HTML\",\n                 other:   \"HTML\"\n             }\n        }\n    });\n/*]]>*///-->\n</script>")
;; (setq org-latex-create-formula-image-program 'imagemagick)
(setq org-latex-create-formula-image-program 'dvipng)
;;---------------------------------------------------------
;; Babel
;;---------------------------------------------------------
;; (require 'org-install)

;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '(
;;    (sh . t)
;;    (python . t)
;;    (ruby . t)
;;    (perl . t)

;;    (C . t)
;;    ;; (cpp . t)

;;    (ditaa . t)
;;    (dot . t)
;;    (R . t)
;;    (octave . t)
;;    (matlab . t)
;;    (gnuplot . t)
;;    (sqlite . t)

;;    (emacs-lisp . t)
;;    (scheme . t)
;;    (lisp . t)
;;    (haskell . t)

;;    (awk . t)
;;    (latex . t)

;;    (js . t)
;;    (css . t)
;;    (sass . t)
;;    ))
;; ;; don't confirm when evaluate the code
;; (setq org-confirm-babel-evaluate nil)

;;-------------------------------------------------------------------
;;      auto fill paragraphs
;;-------------------------------------------------------------------
(add-hook 'org-mode-hook '(lambda ()
                            (setq-default fill-column 79)
                            (turn-on-auto-fill)))
;;; vim's o command
(defun org-vi-open-line-below ()
  (interactive)
  (org-end-of-line 1)
  (newline-and-indent))

(setq org-special-ctrl-a/e t)
(defun org-smarter-move-beginning-of-line (arg)
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point))
        (special (if (consp org-special-ctrl-a/e)
		     (car org-special-ctrl-a/e)
		   org-special-ctrl-a/e)))
    (if (and (org-at-heading-or-item-p) special)
        (org-beginning-of-line)
      (progn
        (back-to-indentation)
        (when (= orig-point (point))
          (move-beginning-of-line 1))))))

(add-hook 'org-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-o") 'org-vi-open-line-below)
             (local-set-key (kbd "C-a") 'org-smarter-move-beginning-of-line)))

;;; highlight code in src block
(setq org-src-fontify-natively t)

(provide 'personal-org)
;;; personal-org.el ends here
