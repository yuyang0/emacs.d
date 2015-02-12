;;; personal-settings.el --- some personal settings
;; Time-stamp: <2013-12-18 16:05:20 Wednesday by Yu Yang>
;;; Author: Yu Yang <yy2012cn@NOSPAM.gmail.com>
;;; URL: https://github.com/yuyang0/
;;;
;;; Commentary:
;;    this file contain some useful function and keybings
;;    this file is not in purcell's config files

;; Usage:
;;
;;; Code:

;;设置有用的个人信息
(setq user-full-name "Yu Yang")
(setq user-mail-address "yy2012cn@gmail.com")

;;扩展存放数据文件与自动保存的临时文件的目录
(setq backup-directory-alist
      `((".*" . ,*temp-dir*)))
(setq auto-save-file-name-transforms
      `((".*" ,*temp-dir* t)))
;;; store the auto-save-list dir in *temp-dir*
(setq auto-save-list-file-prefix
      (expand-file-name "auto-save-list/.saves-" *temp-dir*))
;;光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线。
(mouse-avoidance-mode 'animate)
;;sentence-end识别中文标点
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")

(setq-default tab-width 8)
(global-linum-mode +1)
;;; 自动匹配括号,引号
(electric-pair-mode +1)
;; the blinking cursor is nothing, but an annoyance
(blink-cursor-mode -1)

;;-------------------------------------------------------------------
;;               auto fill(only comment when in code source file
;;-------------------------------------------------------------------
(dolist (a-mode-hook
         '(c-mode-common-hook php-mode-hook python-mode-hook ruby-mode-hook
                              sh-mode-hook))

  (add-hook a-mode-hook
            '(lambda ()
               (auto-fill-mode 1)
               (set (make-local-variable 'fill-nobreak-predicate)
                    (lambda ()
                      (not (eq (get-text-property (point) 'face)
                               'font-lock-comment-face)))))))

;;---------------------------------------------------------
;;   kill line or region
;;---------------------------------------------------------
;;----------advice a function to support region operation------------------
(defmacro region-support-advice (origin-func region-func advice-name &optional doc)
  "define Advice named `ADVICE-NAME' on `ORIGIN-FUNC'.

 if the region is active, run `REGION-FUNC', otherwith run `ORIGIN-FUNC'"
  `(defadvice ,origin-func (around ,advice-name activate)
     (if (region-active-p)
         (,region-func (region-beginning) (region-end))
       ad-do-it)))

(region-support-advice kill-line kill-region yy-kill-line-or-region)
(after-load 'org
  (region-support-advice org-kill-line kill-region yy-org-kill-line-or-region))

(defun paredit-duplicate-line-or-region (prefix)
  "This command has same behavior of duplicate-line-or-region.
except it will keep the braces balance when duplicate the line"
  (interactive "*p")
  (if (region-active-p)
      (duplicate-region (region-beginning) (region-end))
    (save-excursion
      (back-to-indentation)
      (let* ((start (point))
             (line-end (line-end-position))
             (sexp-end (progn (forward-sexp) (point)))
             (cur-line (buffer-substring-no-properties start line-end))
             (cur-sexp (buffer-substring-no-properties start sexp-end)))

        (if (s-starts-with? ";" cur-line)
            ;; if current line is comment, then just insert this line
            (progn
              (goto-char line-end)
              (paredit-newline)
              (insert cur-line))
          (progn
            (paredit-newline)
            (insert cur-sexp)))))))

(after-load 'paredit
  (region-support-advice paredit-kill paredit-kill-region
                         yy-paredit-kill-line-or-region)
  (region-support-advice paredit-backward-delete paredit-delete-region
                         yy-paredit-del-backward-char-or-region)
  (region-support-advice paredit-forward-delete paredit-delete-region
                         yy-paredit-del-forward-char-or-region)
  (define-key paredit-mode-map (kbd "C-c p") 'paredit-duplicate-line-or-region))
;;-------------------------------------------------------------------
;;--------给backspace，C-d，delete添加delete-region功能----------------
(unless delete-active-region
  (setq delete-active-region t))

(region-support-advice upcase-word upcase-region yy-upcase-word-or-region)
(region-support-advice downcase-word downcase-region
                       yy-downcase-word-or-region)
(region-support-advice capitalize-word capitalize-region
                       yy-capitalize-word-or-region)
(global-set-key (kbd "C-x C-u") 'upcase-word)
(global-set-key (kbd "C-x C-l") 'downcase-word)

;; delete all whitespace in the end of line.but don't remove the blank lines
;; at the end of buffer.because some program source file must end with an
;; blank line(for example:the source file for flex)
(setq delete-trailing-lines nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;;---------------------------------------------------------
;;---------调用stardict的命令行程序sdcv(sudo apt-get install sdcv)------
;; http://sdcv-mode.googlecode.com/svn/trunk/sdcv-mode.el ----
;;----------- author: pluskid---------------------------------
(require 'sdcv-mode)

;;--------------------------------------------------------------------
;;        template.el
;;--------------------------------------------------------------------
(require 'template)
(template-initialize)
(add-to-list 'template-default-directories
             (expand-file-name "template/templates" *vendor-dir*))
(add-to-list 'template-find-file-commands 'ido-exit-minibuffer)
(add-to-list 'template-find-file-commands 'helm-exit-minibuffer)

;;------------------------------------------------------------------
;; sourcegraph mode
;;------------------------------------------------------------------
(require 'sourcegraph)
;;------------------------------------------------------------------
;;          高亮超过80字符的行(只高亮超过80的部分)
;;------------------------------------------------------------------
(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))

(add-hook 'prog-mode-hook 'whitespace-mode)

;;--------------------------yafolding--------------------------------
(require 'yafolding)
(global-set-key (kbd "C-c f") 'yafolding)
;;-------------------------------------------------------------------
;; some key bindings of read only mode(info-mode, help-mode, view-mode)
;;-------------------------------------------------------------------
(defmacro enable-vim-key-bindings (hook mode-map)
  "enable vim style key bindings."
  `(add-hook ,hook
             (lambda ()
               (define-key ,mode-map (kbd "h") 'backward-char)
               (define-key ,mode-map (kbd "j") 'next-line)
               (define-key ,mode-map (kbd "k") 'previous-line)
               (define-key ,mode-map (kbd "l") 'forward-char))))
(enable-vim-key-bindings 'Info-mode-hook Info-mode-map)
(enable-vim-key-bindings 'help-mode-hook help-mode-map)
(enable-vim-key-bindings 'view-mode-hook view-mode-map)
(add-hook 'view-mode-hook
          (lambda ()
            (define-key view-mode-map (kbd "%") 'personal-goto-matched-paren)))
;;----------------------------------------------------------------------------
;; my settings for init-editing-utils
;;----------------------------------------------------------------------------
(require-package 'phi-search)
(require 'multiple-cursors)
(eval-after-load  'multiple-cursors
  '(progn
     (define-key mc/keymap (kbd "C-s") 'phi-search)
     (define-key mc/keymap (kbd "C-r") 'phi-search-backward)))

(global-set-key (kbd "C-s") 'isearch-forward-regexp)
(global-set-key (kbd "C-r") 'isearch-backward-regexp)

;;在搜索的时候自动跳到结果的开始
(defun custom-goto-match-beginning()
  (when isearch-forward(goto-char isearch-other-end)))
(add-hook 'isearch-mode-end-hook 'custom-goto-match-beginning)

;;----------------------------------------------------------------------------
;; auto-complete settings(auto start the popup menu)
;;----------------------------------------------------------------------------
(eval-after-load 'auto-complete
  (progn
    (setq ac-auto-start 2)
    (setq ac-auto-show-menu t)))

;;----------------------------------------------------------------------------
;;       dired personal settings
;;----------------------------------------------------------------------------
(defvar open-external-exts '("pdf" "mp4" "mp3" "avi" "rmvb" "rm"
                             "doc" "docx" "ppt" "pptx" "xls" "xlsx" "deb")
  "File should open with external app.")

(after-load 'dired
  (toggle-diredp-find-file-reuse-dir +1)

  (defadvice diredp-find-file-reuse-dir-buffer (around diredp-open-external-app activate)
    (let ((filename (dired-get-file-for-visit)))
      (if (and (member (file-name-extension filename) open-external-exts)
               (yes-or-no-p (format "open %s with external app" filename)))
          (personal-open-file-in-external-app filename)
        ad-do-it)))
  (defadvice dired-find-file (around dired-open-external-app activate)
    (let ((filename (dired-get-file-for-visit)))
      (if (and (member (file-name-extension filename) open-external-exts)
               (yes-or-no-p (format "open %s with external app" filename)))
          (personal-open-file-in-external-app filename)
        ad-do-it))))

;;----------------------------------------------------------------------------
;; smarter kill-ring navigation
;;----------------------------------------------------------------------------
(require-package 'browse-kill-ring)
(browse-kill-ring-default-keybindings)
(global-set-key (kbd "s-y") 'browse-kill-ring)

;; use shift + arrow keys to switch between visible buffers
(require 'windmove)
(windmove-default-keybindings)

;; define function to shutdown emacs server instance
(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server."
  (interactive)
  (save-some-buffers)
  (kill-emacs))

(require 'personal-mode)
(personal-global-mode)
;;----------------------------------------------------------------------------
;; display currfent time in mode line, It's usefull when the emacs frame is
;; maximized
;;----------------------------------------------------------------------------
(display-time)
;;----------------------------------------------------------------------------
;; some global key bindings
;;----------------------------------------------------------------------------
(global-set-key (kbd "<f8>") 'sanityinc/split-window)
(global-set-key (kbd "C-x p") 'proced)
(global-set-key (kbd "C-x o") 'switch-window)
(global-set-key (kbd "C-c d") 'sdcv-search)
(after-load 'lisp-mode
  (define-key lisp-interaction-mode-map (kbd "<f5>") 'eval-print-last-sexp)
  (define-key emacs-lisp-mode-map (kbd "<f5>") 'sanityinc/eval-last-sexp-or-region)
  (define-key emacs-lisp-mode-map (kbd "<f7>") 'personal-visit-scratch-buffer))

;;----------------------------------------------------------------------------
;;  some useful packages
;;----------------------------------------------------------------------------
(require-packages '(url-shortener nginx-mode s web-beautify))
(add-to-list 'auto-mode-alist
             '("\\.sls\\'"  . yaml-mode))
;;----------------------------------------------------------------------------
;; unset key
;;----------------------------------------------------------------------------
(global-unset-key (kbd "C-z"))          ;stop from minimizing the window
(provide 'personal-settings)
;;; personal-settings.el ends here
