;; 功能:
;; emacs外观设置
;;
;; 2012年1月6日

;; 基本外观
;;======================================================================

;个性化配色 
(require 'color-theme)
(color-theme-initialize)
;; (color-theme-arjen)
;; (color-theme-julie)
(color-theme-blackboard)

; 显示列号
(setq column-number-mode t)

; 不要滚动条
(customize-set-variable 'scroll-bar-mode nil)

; 在fringe上显示一个小箭头指示当前buffer的边界
(setq-default indicate-buffer-boundaries 'left)

; init message
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

; 不要menu-bar和tool-bar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; 在状态栏显示日期时间
(setq display-time-day-and-date nil)
(display-time)

;; 用对应的颜色显示你的颜色字符串, i.e. red blue #96bf33
(require 'rainbow-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-mode)
(add-hook 'xhtml-mode-hook 'rainbow-mode)
(add-hook 'html-mode-hook 'rainbow-mode)
;; (add-hook 'python-mode-hook 'rainbow-mode)

;; linum+ settings
;;======================================================================
(require 'linum+)
(setq linum-format '("%%%dd|"))
(add-hook 'text-mode-hook 'linum-mode)
(add-hook 'emacs-lisp-mode-hook 'linum-mode)
(add-hook 'xhtml-mode-hook 'linum-mode)
(add-hook 'html-mode-hook 'linum-mode)
(add-hook 'python-mode-hook 'linum-mode)


;; 字体设置
;;======================================================================

;; (set-default-font "DejaVu Sans Mono:pixelsize=13")
(set-default-font "微软雅黑Monaco:pixelsize=13")

;; (require 'cl)
;; (defun qiang-font-existsp (font)
;;   (if (null (x-list-fonts font))
;;       nil t))
;; (defvar font-list '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))
;; (defun qiang-make-font-string (font-name font-size)
;;   (if (and (stringp font-size) 
;;            (equal ":" (string (elt font-size 0))))
;;       (format "%s%s" font-name font-size)
;;     (format "%s %s" font-name font-size)))
;; (defun qiang-set-font (english-fonts
;;                        english-font-size
;;                        chinese-fonts
;;                        &optional chinese-font-size)
;;   "english-font-size could be set to \":pixelsize=18\" or a integer.
;; If set/leave chinese-font-size to nil, it will follow english-font-size"
;;   (let ((en-font (qiang-make-font-string
;;                   (find-if #'qiang-font-existsp english-fonts)
;;                   english-font-size))
;;         (zh-font (font-spec :family (find-if #'qiang-font-existsp chinese-fonts)
;;                             :size chinese-font-size))) 
;;     (message "Set English Font to %s" en-font)
;;     (set-face-attribute
;;      'default nil :font en-font)
;;     (message "Set Chinese Font to %s" zh-font)
;;     (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;       (set-fontset-font (frame-parameter nil 'font)
;;                         charset
;;                         zh-font))))
;; (qiang-set-font
;;  '("DejaVu Sans Mono" "微软雅黑Monaco" "Consolas"  "Monospace" "Courier New") ":pixelsize=12"
;;  '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "宋体" "新宋体"))

;; tabbar
;;======================================================================
(require 'tabbar)
(tabbar-mode)
(define-prefix-command 'lwindow-map)
;; tabbar 外观设置
(set-face-attribute 'tabbar-default nil  
                    :family "微软雅黑Monaco"
                    :background "#505050"
		    :foreground "#909737" 
                    :height 1.0
                    )

(set-face-attribute 'tabbar-button nil  
                    :inherit 'tabbar-default  
                    :box '(:line-width 1 :color "#909737")  
                    )

(set-face-attribute 'tabbar-selected nil  
                    :inherit 'tabbar-default  
                    :foreground "yellow";DarkGreen"  
                    :background "#202020";LightGoldenrod"
                    :box '(:line-width 1 :color "#909737")  
                    :overline "#909737"  
                    :underline nil  
                    :weight 'normal
                    )

(set-face-attribute 'tabbar-unselected nil  
                    :inherit 'tabbar-default  
                    :box '(:line-width 1 :color "#909737")  
                    )


;; cursor settings
;;================================================================================

(require 'cursor-chg)
(defgroup cursor-change nil
  "Group for cursor-change."
  :group 'cursor
  :prefix "cursor-change-")

(defvar cursor-change-old-cursor-type nil "Cursor type before toggle on function `cursor-change-mode'.")
(defvar cursor-change-old-blink-cursor-mode nil "`blink-cursor-mode' before toggle on function `crsor-change-mode'.")

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
  "Set cursor type differently for overwrite mode, function `view-mode', and read-only buffer.
That is, use one cursor type for overwrite mode and read-only buffers,
and another cursor type otherwise."
  (curchg-set-cursor-type
   (if (or buffer-read-only overwrite-mode view-mode)
       curchg-overwrite/read-only-cursor-type
     curchg-default-cursor-type)))

(cursor-change-mode 1)
