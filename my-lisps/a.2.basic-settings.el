;; 功能:
;; 基本功能设置
;;
;; 修改时间:
;; 2011年12月11日

;; basic settings
;; ======================================================================

; emacs working directory
(setq default-directory "~/work/src/")

;; bakup设置
(setq auto-save-default nil)                         ; 不生成 #filename# 文件
(setq make-backup-files t)	                     ; 设定不产生备份文件
(setq auto-save-mode nil)		             ; 自动保存模式
;; (setq-default make-backup-files t)                ; 不生成临时文件
(setq   delete-old-versions   t)
;; (setq version-control 'never)                     ; 启用版本控制，即可以备份多次
(setq kept-old-versions 2)                           ; 备份最原始的版本两次，及第一次编辑前的文档，和第二次编辑前的文档
(setq kept-new-versions 1)                           ; 备份最新的版本1次，理解同上
(setq delete-old-versions t)	                     ; 删掉不属于以上3中版本的版本
(setq backup-directory-alist '((" " . "~/backup/"))) ; 设置备份文件的路径
(setq backup-by-copying t)			     ; 备份设置方法，直接拷贝

;; 缩进设置
; 总是使用空格缩进
(setq indent-tabs-mode nil)
; 在一行的任意地方使用tab缩进
(setq tab-always-indent t)
; 使用4个空格缩进
(setq tab-width 4)


;; 不显示Emacs的开始画面
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; 不要总是没完没了的问yes or no, 为什么不能用y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; 不要闪烁光标, 烦不烦啊
(blink-cursor-mode -1)


; 鼠标中键粘贴
(setq mouse-yank-at-point t)

; 一行的宽度最大80 使用 C-q 切行
(setq default-fill-column 80)

; 与其他程序共享剪切版
(setq x-select-enable-clipboard t)

; 关闭buffer的时候, 如果该buffer有对应的进程存在, 不提示
(delq 'process-kill-buffer-query-function kill-buffer-query-functions)

;; 不要menu-bar和tool-bar
(menu-bar-mode nil)
(tool-bar-mode nil)

;; 显示列号
(setq column-number-mode t)

;; 个人信息
(setq user-mail-address "leeway185@gmail.com")
(setq user-full-name    "pylemon")

;; 在fringe上显示一个小箭头指示当前buffer的边界
(setq-default indicate-buffer-boundaries 'left)

;; 尽快显示按键序列
(setq echo-keystrokes 0.1)

;; 不要滚动条
(customize-set-variable 'scroll-bar-mode nil)

;; Emacs找不到合适的模式时，缺省使用text-mode
(setq default-major-mode 'text-mode)

;; emacs lock
(autoload 'toggle-emacs-lock "emacs-lock" "Emacs lock" t)

;; 启用以下功能
(put 'narrow-to-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)

;; 防止页面滚动时跳动,scroll-margin 3可以在靠近屏幕边沿3行时就开始滚动,可以很好的看到上下文
(setq scroll-margin 3
      scroll-conservatively 10000)

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

;; 先格式化再补全
(setq tab-always-indent 'complete)


; 在dired中忽略下面文件
(setq dired-omit-extensions '("CVS/" ".o" "~" ".bin" ".lbin"
                              ".fasl" ".ufsl" ".a" ".ln" ".blg"
                              ".bbl" ".elc" ".lof" ".glo" ".idx"
                              ".lot" ".fmt" ".tfm" ".class" ".fas" ".lib"
                              ".x86f" ".sparcf" ".lo" ".la" ".toc" ".log"
                              ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr"
                              ".cps" ".fns" ".kys" ".pyc" ".tps" ".vrs" ".pgs"))


;; ibus mode settings
;;================================================================================

(require 'ibus)
;; Turn on ibus-mode automatically after loading .emacs
(add-hook 'after-init-hook 'ibus-mode-on)
;; Use C-SPC for Set Mark command
(ibus-define-common-key ?\C-\s nil)
;; Use C-/ for Undo command
(ibus-define-common-key ?\C-/ nil)
;; Change cursor color depending on IBus status
;(setq ibus-cursor-color '("red" "blue" "limegreen"))
;; Use s-SPC to toggle input status
(ibus-define-common-key ?\S-\s nil)

;; tabbar
(require 'tabbar)
(tabbar-mode)
(define-prefix-command 'lwindow-map)


;; 用对应的颜色显示你的颜色字符串, i.e. red blue #96bf33
(require 'rainbow-mode)
(rainbow-mode t)

;; 很炫的`highligh-tail mode'在输入时高亮输入区域
(require 'highlight-tail)
(setq highlight-tail-colors
          '(("black" . 0)
            ("#bc2525" . 25)
            ("black" . 66)))
(highlight-tail-mode t)



;; cursor settings
;;================================================================================
(require 'cursor-chg)

(defgroup cursor-change nil
  "Group for cursor-change."
  :group 'cursor
  :prefix "cursor-change-")

(defvar cursor-change-old-cursor-type nil "Cursor type before toggle on function `cursor-change-mode'.")
(defvar cursor-change-old-blink-cursor-mode nil "`blink-cursor-mode' before toggle on function `crsor-change-mode'.")

(setq curchg-default-cursor-color "green")

;;;###autoload
(define-minor-mode cursor-change-mode
  "Toggle `cursor-change-mode'."
  :global t
  :group 'cursor-change
  (if cursor-change-mode
      (progn
        (setq cursor-change-old-cursor-type (cursor-change-get-cursor-type))
        (setq cursor-change-old-blink-cursor-mode blink-cursor-mode))
    (blink-cursor-mode (if cursor-change-old-blink-cursor-mode 1 -1)))
  (toggle-cursor-type-when-idle cursor-change-mode)
  (change-cursor-mode cursor-change-mode)
  (unless cursor-change-mode
    (curchg-set-cursor-type cursor-change-old-cursor-type)))

(defun cursor-change-get-cursor-type (&optional frame)
  "Get cursor type of frame FRAME."
  (cdr (assq 'cursor-type (frame-parameters frame))))

(defun curchg-change-cursor-on-overwrite/read-only ()
  "Set cursor type differently for overwrite mode, function `view-mode', and read-only buffer.
That is, use one cursor type for overwrite mode and read-only buffers,
and another cursor type otherwise."
  (curchg-set-cursor-type
   (if (or buffer-read-only overwrite-mode view-mode)
       curchg-overwrite/read-only-cursor-type
     curchg-default-cursor-type)))

 (cursor-change-mode 1)

;; 一些基本的小函数
(require 'ahei-misc)
