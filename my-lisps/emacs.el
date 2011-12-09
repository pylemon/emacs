
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

;; dir mode settings
;;===================================================================
(setq dired-omit-extensions '("CVS/" ".o" "~" ".bin" ".lbin"
                              ".fasl" ".ufsl" ".a" ".ln" ".blg"
                              ".bbl" ".elc" ".lof" ".glo" ".idx"
                              ".lot" ".fmt" ".tfm" ".class" ".fas" ".lib"
                              ".x86f" ".sparcf" ".lo" ".la" ".toc" ".log"
                              ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr"
                              ".cps" ".fns" ".kys" ".pyc" ".tps" ".vrs" ".pgs"))


;; basic function settings
;; ======================================================================

; prevent autosaving
(setq make-backup-files nil)

; back up dir
(setq backup-directory-alist '(("" . "~/Emacs/backup/")))

; always using space to indent
(setq indent-tabs-mode nil)

; indent anywhere inline
(setq tab-always-indent t)

; indent tab width 4 space
(setq tab-width 4)

; middle mouse key past
(setq mouse-yank-at-point t)

; change line 80 char
(setq default-fill-column 80)

; emacs clipboard with other programme
(setq x-select-enable-clipboard t)

;; emacs working directory
(setq default-directory "~/work/src/")

;; 使用鼠标滚轮翻页时，一次只翻3行
(defun up-slightly () (interactive) (scroll-up 3))
(defun down-slightly () (interactive) (scroll-down 3))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly) 

;; 使用M-;时，如果没有区域被选中且光标不在行尾，直接注释掉当前行
(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and we are not at the end of the line,
then comment current line.
Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'qiang-comment-dwim-line)

;;一些好用的键盘绑定

;显示当前buffer的路径，绑定到M-5
(defun display-buffer-name ()
  (interactive)
  (message (buffer-file-name (current-buffer))))
(global-set-key (kbd "M-5") 'display-buffer-name)

;; 关闭buffer的时候, 如果该buffer有对应的进程存在, 不提示, 烦
(delq 'process-kill-buffer-query-function kill-buffer-query-functions)


;立即关闭当前buffer不需要确认，绑定到M-4
(defun yic-kill-current-buffer ()
  "Kill current buffer."
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "M-4") 'yic-kill-current-buffer)


(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-0") 'other-window)


; 找到鼠标指针当前所在的文件，返回到minibuffer中已供打开
(global-set-key (kbd "C-x f") 'find-file-at-point)

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

;; ;; font settings for better CJK support
;; ;;
;;(setq set-default-font "DejaVu Sans Mono")
;; (set-fontset-font (frame-parameter nil 'font)
;;           'unicode '("Microsoft YaHei" . "unicode-bmp")) 
;; (set-fontset-font (frame-parameter nil 'font)
;;           'han '("Microsoft YaHei" . "unicode-bmp"))
;; (set-fontset-font (frame-parameter nil 'font)
;;           'symbol '("Microsoft YaHei"  . "unicode-bmp"))
;; (set-fontset-font (frame-parameter nil 'font)
;;           'cjk-misc '("Microsoft YaHei"  . "unicode-bmp"))
;; (set-fontset-font (frame-parameter nil 'font)
;;           'bopomofo '("Microsoft YaHei"  . "unicode-bmp")) 


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
(global-set-key (kbd "<M-up>") 'tabbar-backward-group)
(global-set-key (kbd "<M-down>") 'tabbar-forward-group)
(global-set-key (kbd "<M-left>") 'tabbar-backward)
(global-set-key (kbd "<M-right>") 'tabbar-forward)
;(set-face-attribute 'tabbar-default-face nil :family "DejaVu Sans-10")


;; 全屏函数
(defun my-fullscreen ()
  (interactive)
;  (tool-bar-mode nil)
;  (menu-bar-mode nil)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0)))

;该函数用于最大化,状态值为1说明最大化后不会被还原
;因为这里有两次最大化 (分别是水平和垂直)
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))
 
(run-with-idle-timer 0.1 nil 'my-fullscreen)

(global-set-key (kbd "<f11>") 'my-fullscreen)

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

;; ibus settings
(global-unset-key (kbd "C-SPC"))
(global-set-key (kbd "s-SPC") 'set-mark-command)

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
(global-set-key (kbd "C-SPC") 'ibus-toggle)


;; buffer switch settings
;;================================================================================

;; Support functions for `stesla-rotate-buffers'.  From the EmacsWiki.
(defvar stesla-hated-buffers '("KILL" "*Apropos*" "*Completions*" "*grep*"
			       ".newsrc-dribble" ".bbdb" "sent-mail" "*vc*"
                               "*Compile-Log*" "*Help*" "*Messages*" "*scrath*"
			       "*Shell Command Output*"))       
(defvar stesla-hated-buffer-regexps '("^ " "*Buffer" "^\\*trace" "^\\*tramp"))
(setq iswitchb-buffer-ignore (append stesla-hated-buffer-regexps  stesla-hated-buffers))

(defmacro stesla-buffer-regexp-mapcar (regexp buffers)
  "Find BUFFERS whose name matches REGEXP"
  `(mapcar (lambda (this-buffer)
             (if (string-match ,regexp (buffer-name this-buffer))
                 this-buffer))
           ,(if (symbolp buffers) (symbol-value buffers) buffers)))
(defmacro stesla-hated-buffer-from-regexps (regexps)
  "Generate a one-dimensional list of buffers that match REGEXPS"
  (append
   '(append)
   (mapcar (lambda (regexp)
             `(delete nil (stesla-buffer-regexp-mapcar ,regexp
                                                       (buffer-list))))
           (if (symbolp regexps) (symbol-value regexps) regexps))))
(defun stesla-delete-from-list (delete-these from-list)
  "Delete DELETE-THESE from FROM-LIST."
  (cond
   ((car delete-these)
    (if (member (car delete-these) from-list)
        (stesla-delete-from-list (cdr delete-these)
				 (delete (car delete-these) from-list))
      (stesla-delete-from-list (cdr delete-these) from-list)))
   (t from-list)))
(defun stesla-hated-buffers ()
  "List of buffers I never want to see."
  (delete nil
          (append
           (mapcar 'get-buffer stesla-hated-buffers)
           (stesla-hated-buffer-from-regexps stesla-hated-buffer-regexps))))
;; `stesla-rotate-buffers': Like `bury-buffer' but with the capability to
;; exclude certain specified buffers.
(defun stesla-rotate-buffers (&optional n)
  "Switch to the Nth next buffer.  Negative arguments move backwards."
  (interactive)
  (unless n
    (setq n 1))
  (let ((my-buffer-list
         (stesla-delete-from-list (stesla-hated-buffers)
				  (buffer-list (selected-frame)))))
    (switch-to-buffer
     (if (< n 0)
         (nth (+ (length my-buffer-list) n)
              my-buffer-list)
       (bury-buffer)
       (nth n my-buffer-list)))))
;; Windows-style C-TAB and C-M-TAB to switch buffers.
(global-set-key (kbd "s-<tab>") 'stesla-rotate-buffers)
(global-set-key (kbd "s-`") (lambda ()
                                    (interactive)
                                    (stesla-rotate-buffers -1)))

(require 'wcy-swbuff)
;; then you can use <C-tab> and <C-S-kp-tab> to switch buffer.
(global-set-key (kbd "<C-tab>") 'wcy-switch-buffer-forward)
(global-set-key (kbd "C-`") 'wcy-switch-buffer-backward)

(setq wcy-switch-buffer-active-buffer-face  'highlight)
(setq wcy-switch-buffer-inactive-buffer-face  'secondary-selection )

;; This is C-TAB and C-M-TAB for the Linux console.  This requires special
;; setup; namely, you need to load a keymap file with /usr/bin/loadkeys
;; containing the following lines:
;;
;; control keycode 15 = Macro
;; control alt keycode 15 = Pause
;;
;; If you actually -have- a key that generates the Macro or Pause keysyms,  you 
;; have a better keyboard than I.  For me, this makes Emacs DWIW.  Credit for
;; this hack goes to Alex Schroeder.

;; (global-set-key (kbd "ESC [ M") 'stesla-rotate-buffers)
;; (global-set-key (kbd "ESC [ P") (lambda ()
;;                                   (interactive)
;;                                   (stesla-rotate-buffers -1)))

