;; basic settings
;; ======================================================================

;; bakup设置
; 不生成 #filename# 文件
(setq auto-save-default nil)
; 设定不产生备份文件					
(setq make-backup-files t)
; 备份文件存放路径
(setq backup-directory-alist '(("" . "~/backup/")))
; 自动保存模式
(setq auto-save-mode nil)

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

