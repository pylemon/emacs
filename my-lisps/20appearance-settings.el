;; 功能:
;; emacs外观设置
;;
;; 2012年1月6日

;; 基本外观
;;======================================================================

;; 高亮当前行
;; (global-hl-line-mode 1)
;; (set-face-background 'hl-line "#222")

;; mode line 状态栏内容
;; (setq-default mode-line-format
;;               (quote
;;                (" "
;;                 ;; mode string
;;                 (:propertize global-mode-string face 'mode-line-mode-string)
;;                 "  "
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
;;                 "   @ "
;;                 ;; line #
;;                 "line %l, %p")))


;; minimap
(require 'minimap)

;个性化配色
(require 'color-theme)
(color-theme-initialize)
;; (color-theme-arjen)
;; (color-theme-julie)
(color-theme-tangotango)
;; (color-theme-blackboard)

; 全局语法高亮
(global-font-lock-mode t)

; 显示列号
(setq column-number-mode t)

; 不要滚动条
(customize-set-variable 'scroll-bar-mode nil)

; 在fringe上显示一个小箭头指示当前buffer的边界
(setq-default indicate-buffer-boundaries 'left)

;; minibuffer不要自动变化高度
(setq resize-mini-windows nil)

; init message
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

; 不要menu-bar和tool-bar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; 在状态栏显示日期时间
(setq display-time-24hr-format t)
(setq display-time-day-and-date nil)
(setq display-time-interval 60)
(display-time-mode t)

;; 用对应的颜色显示你的颜色字符串, i.e. red blue #96bf33
(require 'rainbow-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-mode)
;; (add-hook 'xhtml-mode-hook 'rainbow-mode)
;; (add-hook 'html-mode-hook 'rainbow-mode)
;; (add-hook 'python-mode-hook 'rainbow-mode)

;; linum+ settings
;;======================================================================
;; (require 'linum+)
;; (setq linum-format '("%%%dd|"))

;; (add-hook 'text-mode-hook 'linum-mode)
;; (add-hook 'emacs-lisp-mode-hook 'linum-mode)
;; (add-hook 'html-mode-hook 'linum-mode)
;; (add-hook 'python-mode-hook 'linum-mode)


;; 字体设置
;;======================================================================

;; (set-default-font "DejaVu Sans Mono:pixelsize=13")
(set-default-font "微软雅黑Monaco:pixelsize=13")

;; tabbar
;;======================================================================
;; (require 'tabbar)
;; (tabbar-mode)
;; (define-prefix-command 'lwindow-map)
;; ;; tabbar 外观设置
;; (set-face-attribute 'tabbar-default nil
;;                     :family "微软雅黑Monaco"
;;                     :background "#505050"
;;                     :foreground "#909737"
;;                     :height 1.0
;;                     )

;; (set-face-attribute 'tabbar-button nil
;;                     :inherit 'tabbar-default
;;                     :box '(:line-width 1 :color "#909737")
;;                     )

;; (set-face-attribute 'tabbar-selected nil
;;                     :inherit 'tabbar-default
;;                     :foreground "yellow"
;;                     :background "#202020";LightGoldenrod"
;;                     :box '(:line-width 1 :color "#909737")
;;                     :overline "#909737"
;;                     :underline nil
;;                     :weight 'normal
;;                     )

;; (set-face-attribute 'tabbar-unselected nil
;;                     :inherit 'tabbar-default
;;                     :box '(:line-width 1 :color "#909737")
;;                     )


;; cursor settings
;;======================================================================

(require 'cursor-chg)
(defgroup cursor-change nil
  "Group for cursor-change."
  :group 'cursor
  :prefix "cursor-change-")

(defvar cursor-change-old-cursor-type nil
  "Cursor type before toggle on function `cursor-change-mode'.")

(defvar cursor-change-old-blink-cursor-mode nil
  "`blink-cursor-mode' before toggle on function `crsor-change-mode'.")

(setq curchg-default-cursor-color "yellow")

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
  "Set cursor type differently for overwrite mode, function `view-mode',
   and read-only buffer. That is, use one cursor type for overwrite mode and
   read-only buffers, and another cursor type otherwise."
  (curchg-set-cursor-type
   (if (or buffer-read-only overwrite-mode view-mode)
       curchg-overwrite/read-only-cursor-type
     curchg-default-cursor-type)))

(cursor-change-mode 1)
