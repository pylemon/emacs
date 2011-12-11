
(defconst my-emacs-path "~/.emacs.d/dea-read-only/" "我的emacs相关配置文件的路径")
(defconst my-emacs-my-lisps-path  (concat my-emacs-path "my-lisps/") "我自己写的emacs lisp包的路径")
(defconst my-emacs-lisps-path     (concat my-emacs-path "lisps/") "我下载的emacs lisp包的路径")
(defconst my-emacs-templates-path (concat my-emacs-path "templates/") "Path for templates")

;; 把`my-emacs-lisps-path'的所有子目录都加到`load-path'里面
(load (concat my-emacs-my-lisps-path "my-subdirs"))
(my-add-subdirs-to-load-path my-emacs-lisps-path)
(my-add-subdirs-to-load-path my-emacs-my-lisps-path)

;; 一些基本的小函数
(require 'ahei-misc)

;; 利用`eval-after-load'加快启动速度的库
;; 用eval-after-load避免不必要的elisp包的加载
;; http://emacser.com/eval-after-load.htm
(require 'eval-after-load)

(require 'util)

;; 一些Emacs的小设置
(require 'misc-settings)

;; Emacs超强的增量搜索Isearch配置
(require 'isearch-settings)

;; 编码设置
(require 'coding-settings)

;; 鼠标配置
(require 'mouse-settings)

;; 可以把光标由方块变成一个小长条
(require 'bar-cursor)

;; Emacs才是世界上最强大的IDE － 智能的改变光标形状
;; http://emacser.com/cursor-change.htm
(require 'cursor-change)
(cursor-change-mode 1)

; emacs working directory
(setq default-directory "~/work/src/")

;; appearance settings
;;======================================================================

;; `mode-line'显示格式
(require 'mode-line-settings)

;; 很炫的`highligh-tail mode'在输入时高亮输入区域
(require 'highlight-tail)
(setq highlight-tail-colors
          '(("black" . 0)
            ("#bc2525" . 25)
            ("black" . 66)))
(highlight-tail-mode t)

;; 用对应的颜色显示你的颜色字符串, i.e. red blue #96bf33
(require 'rainbow-mode)
      
;; tabbar
(require 'tabbar)
(tabbar-mode)
(define-prefix-command 'lwindow-map)

 
;; 增加更丰富的高亮
(require 'generic-x)


;; dev settings
;;======================================================================

;; 各种语言开发方面的设置
(require 'dev-settings)

;;;;;;change some function;;;;;;;
;;my-lisps/dev-settings.el

;; star-dic(require 'star-dict)
;;my-lisps/star-dict.el

;; 轻量标记语言markdown
(require 'markdown-mode-settings)


