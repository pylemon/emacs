
;; basic
;;======================================================================

;; 显示列号
(setq column-number-mode t)

;; 不要滚动条
(customize-set-variable 'scroll-bar-mode nil)

;; 在fringe上显示一个小箭头指示当前buffer的边界
(setq-default indicate-buffer-boundaries 'left)

;; init message
(setq inhibit-startup-message t)
(setq initial-scratch-message "")

;; 不要menu-bar和tool-bar
(menu-bar-mode -1)
(tool-bar-mode -1)

;; 在状态栏显示日期时间
(setq display-time-day-and-date t)
(display-time)


;; 初始化配色
;;======================================================================

(require 'color-theme)
(color-theme-initialize)
(color-theme-blackboard)

;; 用对应的颜色显示你的颜色字符串, i.e. red blue #96bf33
(require 'rainbow-mode)
;; mode need rainbow-mode
(add-hook 'text-mode-hook 'rainbow-mode)
(add-hook 'emacs-lisp-mode-hook 'rainbow-mode)
(add-hook 'xhtml-mode-hook 'rainbow-mode)
(add-hook 'html-mode-hook 'rainbow-mode)
(add-hook 'python-mode-hook 'rainbow-mode)


;; 很炫的`highligh-tail mode'在输入时高亮输入区域
(require 'highlight-tail)
(setq highlight-tail-colors
          '(("black" . 0)
            ("#bc2525" . 25)
            ("black" . 66)))
(highlight-tail-mode t)

;; mode-line settings
(defun mode-line-face-settings ()
  "Face settings for `mode-line'."
  (unless is-before-emacs-21
    (custom-set-faces
     '(mode-line-buffer-id
       ((((class grayscale) (background light)) (:foreground "LightGray" :background "yellow" :weight bold))
        (((class grayscale) (background dark)) (:foreground "DimGray" :background "yellow" :weight bold))
        (((class color) (min-colors 88) (background light)) (:foreground "Orchid" :background "yellow"))
        (((class color) (min-colors 88) (background dark)) (:foreground "yellow" :background "dark slate blue"))
        (((class color) (min-colors 16) (background light)) (:foreground "Orchid" :background "yellow"))
        (((class color) (min-colors 16) (background dark)) (:foreground "LightSteelBlue" :background "yellow"))
        (((class color) (min-colors 8)) (:foreground "blue" :background "yellow" :weight bold))
        (t (:weight bold))))))
  (if window-system
      (progn
        (set-face-foreground 'mode-line "black")
        (set-face-background 'mode-line "lightgreen")
        (unless is-before-emacs-21
          (set-face-foreground 'mode-line-inactive "black")
          (set-face-background 'mode-line-inactive "white")))
    (set-face-foreground 'mode-line "green")
    (set-face-background 'mode-line "black")
    (unless is-before-emacs-21
      (set-face-foreground 'mode-line-buffer-id "blue")
      (set-face-background 'mode-line-buffer-id "yellow")
      (set-face-foreground 'mode-line-inactive "white")
      (set-face-background 'mode-line-inactive "black")))

  (custom-set-faces
   '(header-line
     ((default
        :inherit mode-line)
      (((type tty))
       :foreground "black" :background "yellow" :inverse-video nil)
      (((class color grayscale) (background light))
       :background "grey90" :foreground "grey20" :box nil)
      (((class color grayscale) (background dark))
       :background "#D58EFFFFFC18" :foreground "blue")
      (((class mono) (background light))
       :background "white" :foreground "black"
       :inverse-video nil
       :box nil
       :underline t)
      (((class mono) (background dark))
       :background "black" :foreground "white"
       :inverse-video nil
       :box nil
       :underline t)))))

(eval-after-load "mode-line-settings"
  '(progn
     (defface mode-line-lines-face
       '((((type tty pc)) :background "red" :foreground "white")
         (t (:background "dark slate blue" :foreground "yellow")))
       "Face used to highlight lines on mode-line.")))

(eval-after-load "faces"
  `(mode-line-face-settings))

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

(require 'cl)
(defun qiang-font-existsp (font)
  (if (null (x-list-fonts font))
      nil t))
(defvar font-list '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))
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
  (let ((en-font (qiang-make-font-string
                  (find-if #'qiang-font-existsp english-fonts)
                  english-font-size))
        (zh-font (font-spec :family (find-if #'qiang-font-existsp chinese-fonts)
                            :size chinese-font-size))) 
    (message "Set English Font to %s" en-font)
    (set-face-attribute
     'default nil :font en-font)
    (message "Set Chinese Font to %s" zh-font)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        charset
                        zh-font))))
(qiang-set-font
 '("DejaVu Sans Mono" "Consolas"  "Monospace" "Courier New" "Monaco"  ) ":pixelsize=14"
 '("文泉驿等宽微米黑" "Microsoft Yahei" "黑体" "宋体" "新宋体"))



;; tabbar
;;======================================================================
(require 'tabbar)
(tabbar-mode)
(define-prefix-command 'lwindow-map)
;; tabbar 外观设置
(set-face-attribute 'tabbar-default nil  
                    :family "DejaVu Sans Mono"  
                    :background "gray90"
		    :foreground "gray30" 
                    :height 1.0  
                    )

(set-face-attribute 'tabbar-button nil  
                    :inherit 'tabbar-default  
                    :box '(:line-width 1 :color "yellow70")  
                    )

(set-face-attribute 'tabbar-selected nil  
                    :inherit 'tabbar-default  
                    :foreground "DarkGreen"  
                    :background "LightGoldenrod"  
                    :box '(:line-width 2 :color "DarkGoldenrod")  
                    :overline "black"  
                    :underline nil  
                    :weight 'bold  
                    )

(set-face-attribute 'tabbar-unselected nil  
                    :inherit 'tabbar-default  
                    :box '(:line-width 2 :color "#00B2BE")  
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

(setq curchg-default-cursor-color "green")

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
