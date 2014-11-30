;;; personal-w3m.el --- Description

;; Copyright (C) 2014 Yu Yang

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

(require-package 'w3m)
(autoload 'w3m "w3m" "interface for w3m on emacs" t)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
(autoload 'w3m-search "w3m-search" "Search words using emacs-w3m." t)
(require 'w3m-lnum)

(setq w3m-use-cookies t)
(setq w3m-home-page "https://www.google.com")

(setq w3m-default-display-inline-images t)
(setq w3m-default-toggle-inline-images t)

(setq w3m-coding-system 'utf-8
      w3m-file-coding-system 'utf-8
      w3m-file-name-coding-system 'utf-8
      w3m-input-coding-system 'utf-8
      w3m-output-coding-system 'utf-8
      w3m-terminal-coding-system 'utf-8
      w3m-bookmark-file-coding-system 'utf-8)
;;; enable link number mode (bind to 'f')
(add-hook 'w3m-mode-hook 'w3m-lnum-mode)
(setq w3m-image-default-background "white")

(require 'w3m-search)
(add-to-list 'w3m-search-engine-alist
             '("emacs-wiki" "http://www.emacswiki.org/cgi-bin/wiki.pl?search=%s"))
(add-to-list 'w3m-search-engine-alist
             '("baidu" "http://www.baidu.com/s?wd=%s"))
(add-to-list 'w3m-search-engine-alist
             '("douban" "http://www.douban.com/search?cat=&q=%s"))
;; (add-hook 'w3m-mode-hook (lambda ()
;;                           (local-set-key (kbd ))))
(defun my-w3m-search-read-variables ()
  "Ask for a search engine and words to query and return them as a list."
  (when w3m-current-process
    (error "%s"
	   (substitute-command-keys "
Cannot run two w3m processes simultaneously \
\(Type `\\<w3m-mode-map>\\[w3m-process-stop]' to stop asynchronous process)")))
  (let* ((search-engine
          (let ((default (or (car w3m-search-engine-history)
                             w3m-search-default-engine))
                (completion-ignore-case t))
            (completing-read (format "Which engine? (default %s): "
                                     default)
                             w3m-search-engine-alist nil t nil
                             'w3m-search-engine-history default)))
	 (query
	  (w3m-search-read-query
	   (format "%s search: " search-engine)
	   (format "%s search (default %%s): " search-engine))))
    (list search-engine query)))
(defun my-w3m-search (search-engine query)
  (interactive (my-w3m-search-read-variables))
  (w3m-search search-engine query))

(defadvice w3m-search (before my-w3m-search-advice activate)
  "advice the w3m-search always propmpt choosing Search engion"
  (interactive (my-w3m-search-read-variables)))

(provide 'personal-w3m)
;;; personal-w3m.el ends here
