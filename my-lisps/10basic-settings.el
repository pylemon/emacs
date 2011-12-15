

;; basic settings
;;======================================================================

; emacs working directory
(setq default-directory "~/work/src/")


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

;; 个人信息
(setq user-mail-address "leeway185@gmail.com")
(setq user-full-name    "pylemon")

;; 尽快显示按键序列
(setq echo-keystrokes 0.1)


;; 缩进设置
;;======================================================================

(setq indent-tabs-mode nil)   	; 总是使用空格缩进
(setq tab-always-indent t)      ; 在一行的任意地方使用tab缩进
(setq tab-width 4)			    ; 使用4个空格缩进


;; bakup设置
;;======================================================================

(setq auto-save-default nil)                         ; 不生成 #filename# 文件
(setq make-backup-files t)   	                     ; 设定不产生备份文件
(setq auto-save-mode nil)		                     ; 自动保存模式
(setq-default make-backup-files t)                   ; 不生成临时文件
(setq delete-old-versions t)
(setq kept-old-versions 2)                           ; 备份最原始的版本两次，及第一次编辑前的文档，和第二次编辑前的文档
(setq kept-new-versions 1)                           ; 备份最新的版本1次，理解同上
(setq delete-old-versions t)	                     ; 删掉不属于以上3中版本的版本
(setq backup-directory-alist '((" " . "~/backup/"))) ; 设置备份文件的路径
(setq backup-by-copying t)	             		     ; 备份设置方法，直接拷贝



;; Emacs找不到合适的模式时，缺省使用text-mode
(setq default-major-mode 'text-mode)

;; emacs lock
(autoload 'toggle-emacs-lock "emacs-lock" "Emacs lock" t)

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
