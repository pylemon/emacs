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

;; 增加更丰富的高亮
(require 'generic-x)

; rst-mode title 背景发白 fixes
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(rst-level-face-base-color "black"))

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
;; (setq display-time-24hr-format t)
;; (setq display-time-day-and-date nil)
;; (setq display-time-interval 60)
(display-time-mode nil)

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
		    :family "profont" ;;"微软雅黑Monaco"
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

;; minimap
;; (require 'minimap)

;; 高亮当前行
(global-hl-line-mode 1)
;; (set-face-background 'hl-line "gray21")

;; 为所有的window 标记号码，使用 C-c 1 切换到 window 1
(require 'window-number)
(window-number-mode)
(window-number-meta-mode)

;; dired-x 过滤不显示的文件， 增强 dired 功能
(require 'dired-x)
(setq dired-omit-files 
      (rx (or (seq bol (? ".") "#")         ;; emacs autosave files 
              (seq "~" eol)                 ;; backup-files 
              (seq bol ".svn" eol)          ;; svn dirs 
              (seq bol ".git" eol)          ;; git dirs 
              (seq ".pyc" eol)              ;; py bin files
              (seq ".gitignore" eol)        ;; gitignore
              (seq ".settings" eol)         ;; eclipse settings
              (seq ".project" eol)          ;; eclipse workspace
              (seq ".pydevproject" eol)     ;; pydev settings
              )))
(setq dired-omit-extensions 
      (append dired-latex-unclean-extensions 
              dired-bibtex-unclean-extensions 
              dired-texinfo-unclean-extensions))
(add-hook 'dired-mode-hook (lambda () (dired-omit-mode 1)))
(put 'dired-find-alternate-file 'disabled nil)

;; 在 ibuffer 中不显示的 buffer， 可以使用 C-x b 切换
(setq ibuffer-never-show-predicates
      (list
       "^\\*scratch"
       "^\\*Message"
       "^\\*Help"
       "^\\*Directory"              ;; do not use list directory
       "^\\*Completions\\*$"
       "^\\*magit-"
))
(setq helm-c-boring-buffer-regexp "^\\*")

;; 自动高亮， 超过 110 个字符的行 
(require 'column-marker)
(mapc (lambda (hook)
        ;; (add-hook hook (lambda () (interactive) (column-marker-1 80)))
	(add-hook hook (lambda () (interactive) (column-marker-1 110)))
	)
      '(org-mode-hook
        emacs-lisp-mode-hook
        python-mode-hook
        js2-mode-hook
        rst-mode-hook
        text-mode-hook))
