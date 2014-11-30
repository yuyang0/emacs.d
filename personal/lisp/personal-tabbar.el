;;; personal-tabbar.el --- Description

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

(require 'tabbar)
(tabbar-mode 1)
;;shift+方向键切换组以及buffer
(global-set-key (kbd "<s-left>") 'tabbar-backward-tab)
(global-set-key (kbd "<s-right>") 'tabbar-forward-tab)
(global-set-key (kbd "<s-up>") 'tabbar-forward-group)
(global-set-key (kbd "<s-down>") 'tabbar-backward-group)
;;分成3个组，所有自己打开的文件一个组
;; (setq tabbar-buffer-groups-function 'my-tabbar-buffer-groups)
;; (defun my-tabbar-buffer-groups()
;;   (list
;;    (cond
;; 	((or (get-buffer-process(current-buffer))
;; 		 (tabbar-buffer-mode-derived-p major-mode '(comint-mode
;; 													compilation-mode)))
;; 	 "Process")
;; 	((string-equal "*" (substring (buffer-name) 0 1))
;; 	 "Emacs Buffer"
;; 	 )
;; 	((eq major-mode 'dired-mode)
;; 	 "Dired")
;; 	(t "User Buffer"))))


;;修改tabbar的外观
(set-face-attribute 'tabbar-default nil
					:family "Inconsolata"
					:background "gray80"
					:foreground "gray30"
					:height 1.0)
(set-face-attribute 'tabbar-button nil
					:inherit 'tabbar-default
					:box '(:line-width 1 :color "gray30"))
(set-face-attribute 'tabbar-selected nil
					:inherit 'tabbar-default
					:foreground "DarkGreen"
					:background "LightGoldenrod"
					:box '(:line-width 2 :color "DarkGoldenrod")
					:weight 'bold)
(set-face-attribute 'tabbar-unselected nil
					:inherit 'tabbar-default
					:box '(:line-width 2 :color "gray70"))

(provide 'personal-tabbar)
;;; personal-tabbar.el ends here
