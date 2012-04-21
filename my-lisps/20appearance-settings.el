;; -------~-------~--~------------------~------------------------~------
;; APPEARANCE
;; -------~-------~--~------------------~------------------------~------

;; 配色方案
(require 'color-theme)
(color-theme-initialize)
(color-theme-zenburn)
;; (color-theme-tangotango)
;; (color-theme-chocolate-rain)
;; (color-theme-molokai)
;; (color-theme-arjen)
;; (color-theme-julie)
;; (color-theme-blackboard)

;; 全局语法高亮
(global-font-lock-mode t)

;; 不要滚动条
(customize-set-variable 'scroll-bar-mode nil)

;; 在fringe上显示一个小箭头指示当前buffer的边界
(setq-default indicate-buffer-boundaries 'left)

;; minibuffer不要自动变化高度
(setq resize-mini-windows nil)

; 初始化页面
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

; 不要menu-bar和tool-bar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; 在状态栏显示日期时间
(setq display-time-24hr-format t)
;; (setq display-time-day-and-date nil)
;; (setq display-time-interval 60)
(display-time-mode t)

;; 用对应的颜色显示你的颜色字符串, i.e. red blue #96bf33
(require 'rainbow-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-mode)
(add-hook 'css-mode-hook 'rainbow-mode)
;; (add-hook 'xhtml-mode-hook 'rainbow-mode)
;; (add-hook 'html-mode-hook 'rainbow-mode)
;; (add-hook 'python-mode-hook 'rainbow-mode)

;; linum+ settings
(require 'linum+)
(setq linum-format '("%%%dd|"))
(add-hook 'text-mode-hook 'linum-mode)
(add-hook 'emacs-lisp-mode-hook 'linum-mode)
(add-hook 'html-mode-hook 'linum-mode)
(add-hook 'python-mode-hook 'linum-mode)
;; (require 'wb-line-number)
;; (wb-line-number-toggle)

;; 字体设置
(set-default-font "微软雅黑Monaco:pixelsize=12")
;; (set-default-font "profont 11")
;; (set-default-font "YaHei Consolas Hybrid:pixelsize=13")
;; (set-default-font "DejaVu Sans Mono:pixelsize=13")

;; tabbar设置
(require 'tabbar)
(tabbar-mode)
(define-prefix-command 'lwindow-map)
(set-face-attribute 'tabbar-default nil
		    :family "profont"  ;;"微软雅黑Monaco"
		    :background "#505050"
		    :foreground "#a0a0a0"
		    :height 0.9
		    )
(set-face-attribute 'tabbar-button nil
		    :inherit 'tabbar-default
		    :box '(:line-width 1 :color "#505050")
		    )
(set-face-attribute 'tabbar-selected nil
		    :inherit 'tabbar-default
		    :background "#505050"
		    :foreground "#96bf33"
		    :overline "#505050"
		    :underline nil
		    :box '(:line-width 1 :color "#96bf33")
		    )
(set-face-attribute 'tabbar-unselected nil
		    :inherit 'tabbar-default
		    :overline "#505050"
		    :box '(:line-width 1 :color "#96bf33")
		    )


;; 高亮光标处单词
(require 'highlight-symbol)
(setq highlight-symbol-idle-delay 0.4)
(highlight-symbol-mode t)



;; mode line 状态栏内容
;; (setq-default mode-line-format
;;               (quote
;;                ("  ..  "
;;                 ;; value of 'mode-name'
;;                 (:propertize "%m" face 'mode-line-mode-name)
;; 		"  "
;;                 ;; file path
;;                 (:propertize (:eval (if (> (length default-directory) 17)
;;                                         (concat ".." (substring default-directory -20))
;;                                       default-directory))
;;                              face 'mode-line-folder-face)
;;                 ;; file name
;;                 (:propertize mode-line-buffer-identification face 'mode-line-buffer-name)
;;                 (:propertize mode-line-modified face 'mode-line-modified-face)
;;                 "   "
;;                 ;; line #
;;                 "Line %l:%c "
;; 		" %s %-"
;;                 ;; mode string
;;                 ;; (:propertize global-mode-string face 'mode-line-mode-string)
;; )))

;; minimap
;; (require 'minimap)

;; 高亮当前行
(global-hl-line-mode 1)
;; (set-face-background 'hl-line "gray21")
