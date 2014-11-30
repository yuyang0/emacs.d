;;; personal-cc.el --- Description

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

;;设置C语言风格
(setq auto-mode-alist
      (append '(("\\.cl\\'" . c-mode))
              auto-mode-alist))

;;(setq imenu-sort-function 'imenu--sort-by-name)

(defun linux-c-mode()
  ;; (c-set-style "K&R")
  ;; (c-toggle-auto-state)
  (c-toggle-auto-newline)
  ;; (setq c-basic-offset 4)
  ;; (imenu-add-menubar-index)
  (which-function-mode +1)
  ;;; enable ac-source-semantic only in c/c++ mode
  ;;switch between header/source and the corresponding source/header file(in other window)
  (local-set-key  (kbd "C-c o") (lambda ()
                                  (interactive)
                                  (ff-find-other-file 3)) )
  (local-set-key (kbd "C-c m") 'man-single-buffer)
  (local-set-key (kbd "<C-f5>") 'smart-compile))

(add-hook 'c-mode-common-hook 'linux-c-mode)

(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)

(add-hook 'c-mode-common-hook
          (lambda ()
            (set (make-local-variable 'company-backends)
                 '((company-semantic company-yasnippet company-clang)))))

;;;;;gdb many windows
;;;gdb的manywindow模式
(setq gdb-many-windows t)

;;----------------在单个buffer显示man文档-------------------------
(defun kill-man-buffer(man-buffer)
  (when (string-match "^\\*Man " (buffer-name man-buffer))
    (kill-buffer man-buffer)))
(defun man-single-buffer(&optional entry)
  (interactive
   (list (read-string(format
                      "Manual entrys(default entry %s):"
                      (thing-at-point 'word)) nil nil
                      (thing-at-point 'word))))
  (mapc 'kill-man-buffer (buffer-list))
  (man entry))
;;-----------shell,gdb退出后，自动关闭该buffer----------------
(add-hook 'shell-mode-hook 'mode-hook-func)
(add-hook 'gdb-mode-hook 'mode-hook-func)

(defun mode-hook-func  ()
  (set-process-sentinel (get-buffer-process (current-buffer))
                        #'kill-buffer-on-exit))
(defun kill-buffer-on-exit (process state)
  (message "%s" state)
  (if (or
       (string-match "exited abnormally with code.*" state)
       (string-match "finished" state))
      (kill-buffer (current-buffer))))
;;--------------------------------------------------------------------
;;------------智能编译，如果是脚本就直接运行 f5------------------------
(defun parent-dir (dir)
  (file-name-directory (substring dir 0 (- (length dir) 1))))
(defun get-top-cmake-dir (dir)
  (let ((par-dir (parent-dir dir)))
    (if (file-readable-p (concat par-dir "CMakeLists.txt"))
        ( get-top-cmake-dir par-dir)
      dir)))
(defun smart-compile()
  "比较智能的C/C++编译命令如果当前目录有makefile则用make -k编译，否则，如果是处于c-mode，就用gcc -Wall编译
  ，如果是c++-mode就用g++ -Wall编译"
  (interactive)
  ;; 查找 Makefile
  (let ((candidate-make-file-name '("makefile""Makefile""GNUmakefile"))
        (command nil))
    (cond
     ((file-readable-p "CMakeLists.txt")
      (let ((top-dir ( get-top-cmake-dir (file-name-directory buffer-file-name))))
        (setq command
              (concat "cd " top-dir " && test -d build || mkdir build && cd build && cmake .. && make"))))
     ((find t candidate-make-file-name :key
            '(lambda (f) (file-readable-p f)))
      (setq command "CFLAGS='-g -Wall' make -k "))
     ;; 没有找到 Makefile ，查看当前 mode 是否是已知的可编译的模式
     ((null (buffer-file-name (current-buffer)))
      (message "Buffer not attached to a file, won't compile!"))
     ((eq major-mode 'c-mode)
      (setq command
            (concat "gcc -Wall -o "
                    (file-name-sans-extension
                     (file-name-nondirectory buffer-file-name))" "
                     (file-name-nondirectory buffer-file-name)" -g -lm ")))
     ((eq major-mode 'c++-mode)
      (setq command
            (concat "g++ -Wall -o"
                    (file-name-sans-extension
                     (file-name-nondirectory buffer-file-name))" "
                     (file-name-nondirectory buffer-file-name)" -g -lm ")))
     (t (message "Unknow mode,won't compile!")))
    (if (not (null command))
        (let ((command (read-from-minibuffer "Compile command: " command)))
          (compile command)))))
;;----------------------------------------------------------------------
;; (require 'personal-cedet)

(provide 'personal-cc)
;;; personal-cc.el ends here
