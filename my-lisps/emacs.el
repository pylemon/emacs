
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


;; dir mode settings
;;===================================================================

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

;; 字体设置
(defun qiang-font-existsp (font)
  (if (null (x-list-fonts font))
      nil t))
(defvar font-list '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))
(require 'cl) ;; find-if is in common list package
(find-if #'qiang-font-existsp font-list)
(defun qiang-make-font-string (font-name font-size)
  (if (and (stringp font-size) 
           (equal ":" (string (elt font-size 0))))
      (format "%s%s" font-name font-size)
    (format "%s %s" font-name font-size)))
(defun qiang-set-font (english-fonts
                       english-font-size
                       chinese-fonts
                       &optional chinese-font-size)
  "english-font-size could be set to \":pixelsize=18\" or a integer.
If set/leave chinese-font-size to nil, it will follow english-font-size"
  (require 'cl)                         ; for find if
  (let ((en-font (qiang-make-font-string
                  (find-if #'qiang-font-existsp english-fonts)
                  english-font-size))
        (zh-font (font-spec :family (find-if #'qiang-font-existsp chinese-fonts)
                            :size chinese-font-size)))
 
    ;; Set the default English font
    ;; 
    ;; The following 2 method cannot make the font settig work in new frames.
    ;; (set-default-font "Consolas:pixelsize=18")
    ;; (add-to-list 'default-frame-alist '(font . "Consolas:pixelsize=18"))
    ;; We have to use set-face-attribute
    (message "Set English Font to %s" en-font)
    (set-face-attribute
     'default nil :font en-font)
 
    ;; Set Chinese font 
    ;; Do not use 'unicode charset, it will cause the english font setting invalid
    (message "Set Chinese Font to %s" zh-font)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        charset
                        zh-font))))
(qiang-set-font
 '("DejaVu Sans Mono" "Consolas" "Monaco" "Monospace" "Courier New") ":pixelsize=14"
 '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))

;; 用对应的颜色显示你的颜色字符串, i.e. red blue #96bf33
(require 'rainbow-mode)

;; 不要menu-bar和tool-bar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; 显示行号
(require 'linum-settings)
(setq linum-format '("%%%dd|"))

      
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

;; star-dict
(require 'star-dict)
;;my-lisps/star-dict.el

;; 轻量标记语言markdown
(require 'markdown-mode-settings)


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
(setq ibus-cursor-color '("red" "blue" "limegreen"))
;; Use s-SPC to toggle input status
(ibus-define-common-key ?\S-\s nil)
