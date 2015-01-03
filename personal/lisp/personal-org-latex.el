;;; personal-org-latex.el --- Description

;; Copyright (C) 2015 Yu Yang

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

(require 'ox-latex)
(setq org-export-latex-listings t)
;; org-mode source code setup in exporting to latex
(add-to-list 'org-latex-listings '("" "listings"))
(add-to-list 'org-latex-listings '("" "color"))

(add-to-list 'org-latex-packages-alist
             '("" "hyperref" t))
(add-to-list 'org-latex-packages-alist
             '("" "xcolor" t))
(add-to-list 'org-latex-packages-alist
             '("" "listings" t))
(add-to-list 'org-latex-packages-alist
             '("" "fontspec" t))
(add-to-list 'org-latex-packages-alist
             '("" "indentfirst" t))
(add-to-list 'org-latex-packages-alist
             '("" "xunicode" t))
(add-to-list 'org-latex-packages-alist
             '("" "amsmath"))
(add-to-list 'org-latex-packages-alist
             '("" "graphicx" t))

(add-to-list 'org-latex-classes
             '("my-org-book-zh"

               "\\documentclass{book}

\\usepackage[slantfont, boldfont]{xeCJK}

% chapter set

\\usepackage[Lenny]{fncychap}

[NO-DEFAULT-PACKAGES]

[PACKAGES]

\\setCJKmainfont{SimSun}

\\parindent 2em

\\setmainfont{DejaVu Sans}

\\setsansfont{DejaVu Serif}

\\setmonofont{DejaVu Sans Mono}

\\defaultfontfeatures{Mapping=tex-text}

\\XeTeXlinebreaklocale \"zh\"

\\XeTeXlinebreakskip = 0pt plus 1pt minus 0.1pt

\\lstset{numbers=left,

numberstyle= \\tiny,

keywordstyle= \\color{ blue!70},commentstyle=\\color{red!50!green!50!blue!50},

frame=shadowbox,

rulesepcolor= \\color{ red!20!green!20!blue!20}

}

[EXTRA]
"

             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(setq org-latex-pdf-process
      '("xelatex -interaction nonstopmode %b"
	"xelatex -interaction nonstopmode %b"))
(provide 'personal-org-latex)
;;; personal-org-latex.el ends here
