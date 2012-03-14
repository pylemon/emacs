;; 功能:
;; emacs基本功能设置
;;
;; 2012年1月6日

(require 'util)
(require 'ahei-misc)

(require 'smooth-scroll)
(smooth-scroll-mode t)

;; 基本设置
;;======================================================================

; emacs工作目录
;(setq default-directory "~/work/src/")

; 个人信息
(setq user-mail-address "leeway185@gmail.com")
(setq user-full-name    "pylemon")

; 启动时全屏显示
;;(defun my-fullscreen ()
;;  (interactive)
;;  (x-send-client-message
;;   nil 0 nil "_NET_WM_STATE" 32
;;   '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
;;(my-fullscreen)

;;在minibuffer里启用自动补全函数和变量
(icomplete-mode 1)

;; 启用部分补全功能，如输入M-x q r r相当于M-x query-replace-regexp
(partial-completion-mode t)

;;当鼠标移动的时候自动转换frame，window或者minibuffer
(setq mouse-autoselect-window t)

;; 不要总是没完没了的问yes or no, 为什么不能用y/n
(fset 'yes-or-no-p 'y-or-n-p)

; 鼠标中键粘贴
(setq mouse-yank-at-point t)

; 一行的宽度最大80 使用 C-q 切行
(setq default-fill-column 80)

; 与其他程序共享剪切版
(setq x-select-enable-clipboard t)

; 关闭buffer的时候, 如果该buffer有对应的进程存在, 不提示
(delq 'process-kill-buffer-query-function kill-buffer-query-functions)

; 搜索时不区分大小写
(setq-default case-fold-search t)

;; Emacs找不到合适的模式时，缺省使用text-mode
(setq default-major-mode 'text-mode)

;; emacs lock
(autoload 'toggle-emacs-lock "emacs-lock" "Emacs lock" t)

;; 防止页面滚动时跳动,scroll-margin 3可以在靠近屏幕边沿3行时就开始滚动,可以很好的看到上下文
;; (setq scroll-margin 3
;;       scroll-conservatively 10000)

;; 没有提示音,也不闪屏
(setq ring-bell-function 'ignore)

;; 可以递归的使用minibuffer
(setq enable-recursive-minibuffers t)

;; 当你在shell、telnet、w3m等模式下时，必然碰到过要输入密码的情况,此时加密显出你的密码
(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)

;; 光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线。
(mouse-avoidance-mode 'animate)

;; 不保存连续的重复的kill
(setq kill-do-not-save-duplicates t)

;; 先格式化再补全(使用tab优先缩进)
(setq tab-always-indent 'complete)

; 在dired中忽略下面文件
(setq dired-omit-extensions '(".elc" ".pyc" ".project" ".pydevproject" ".svn/"))

; 可以递归的删除目录
(setq dired-recursive-deletes t)

; 可以递归的进行拷贝
(setq dired-recursive-copies t)


;; 缩进设置
;;======================================================================

; 总是使用空格缩进
(setq indent-tabs-mode nil)

; 在一行的任意地方使用tab缩进
(setq tab-always-indent t)

; 使用4个空格缩进
(setq tab-width 4)

; 保存时自动删除多余的空格
;; (add-hook 'before-save-hook 'whitespace-cleanup)
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)

;;shell,gdb退出后，自动关闭该buffer
(defun kill-buffer-when-exit ()
  "Close assotiated buffer when a process exited"
  (let ((current-process (ignore-errors (get-buffer-process (current-buffer)))))
    (when current-process
      (set-process-sentinel current-process
                   (lambda (watch-process change-state)
                     (when (string-match "//(finished//|exited//)" change-state)
                    (kill-buffer (process-buffer watch-process))))))))
(add-hook 'gdb-mode-hook 'kill-buffer-when-exit)
(add-hook 'shell-mode-hook 'kill-buffer-when-exit)

;; 备份设置
;;======================================================================

; 不生成 #filename# 文件
(setq auto-save-default nil)

; 设定不产生备份文件
(setq make-backup-files nil)

; 自动保存模式
(setq auto-save-mode nil)

; 不生成临时文件
(setq-default make-backup-files nil)

; 自动删除旧版备份
(setq delete-old-versions t)

; 备份最原始的版本两次，及第一次编辑前的文档，和第二次编辑前的文档
(setq kept-old-versions 2)

; 备份最新的版本1次，理解同上
(setq kept-new-versions 1)

; 删掉不属于以上3中版本的版本
(setq delete-old-versions t)

; 设置备份文件的路径
(setq backup-directory-alist '((" " . "~/backup/")))

; 备份设置方法，直接拷贝
(setq backup-by-copying t)

(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))