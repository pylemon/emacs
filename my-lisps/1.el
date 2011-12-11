(defconst my-emacs-path "~/.emacs.d/dea-read-only/" "我的emacs相关配置文件的路径")
(defconst my-emacs-my-lisps-path  (concat my-emacs-path "my-lisps/") "我自己写的emacs lisp包的路径")
(defconst my-emacs-lisps-path     (concat my-emacs-path "lisps/") "我下载的emacs lisp包的路径")
(defconst my-emacs-templates-path (concat my-emacs-path "templates/") "Path for templates")

;; 把`my-emacs-lisps-path'的所有子目录都加到`load-path'里面
(load (concat my-emacs-my-lisps-path "my-subdirs"))
(my-add-subdirs-to-load-path my-emacs-lisps-path)
(my-add-subdirs-to-load-path my-emacs-my-lisps-path)

(require 'util)
(require 'ahei-misc)
;; Emacs超强的增量搜索Isearch配置
(require 'isearch-settings)

;; 编码设置
(require 'coding-settings)

;; 鼠标配置
(require 'mouse-settings)

;; `mode-line'显示格式
(require 'mode-line-settings)

;; 增加更丰富的高亮
(require 'generic-x)

;; dev settings
;;======================================================================

;; 各种语言开发方面的设置
(require 'dev-settings)
;;;;;;change some function;;;;;;;
;;my-lisps/dev-settings.el

;; 轻量标记语言markdown
(require 'markdown-mode-settings)


