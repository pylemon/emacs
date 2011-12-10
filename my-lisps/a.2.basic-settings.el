;; basic settings
;; ======================================================================

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


; 鼠标中键粘贴
(setq mouse-yank-at-point t)

; 一行的宽度最大80 使用 C-q 切行
(setq default-fill-column 80)

; 与其他程序共享剪切版
(setq x-select-enable-clipboard t)

; 关闭buffer的时候, 如果该buffer有对应的进程存在, 不提示
(delq 'process-kill-buffer-query-function kill-buffer-query-functions)

; 在dired中忽略下面文件
(setq dired-omit-extensions '("CVS/" ".o" "~" ".bin" ".lbin"
                              ".fasl" ".ufsl" ".a" ".ln" ".blg"
                              ".bbl" ".elc" ".lof" ".glo" ".idx"
                              ".lot" ".fmt" ".tfm" ".class" ".fas" ".lib"
                              ".x86f" ".sparcf" ".lo" ".la" ".toc" ".log"
                              ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr"
                              ".cps" ".fns" ".kys" ".pyc" ".tps" ".vrs" ".pgs"))

