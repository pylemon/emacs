;; 功能:
;; 设置所有键盘绑定相关的东东
;;
;; 修改时间:
;; 2012年1月6日

;; <C-?>
;;======================================================================

;; 切换 buffer 向前向后
(require 'wcy-swbuff)
(setq wcy-switch-buffer-active-buffer-face  'highlight)
(setq wcy-switch-buffer-inactive-buffer-face  'secondary-selection )
(global-set-key (kbd "<M-tab>") 'wcy-switch-buffer-forward)
(global-set-key (kbd "<M-S-iso-lefttab>") 'wcy-switch-buffer-backward)

;; 更改设置标记 Mark set
(global-set-key (kbd "M-`") 'set-mark-command)
;; fcitx 输入法切换
(global-set-key (kbd "<C-SPC>") nil)

;; <s-?>
;;=====================================================================

;; 使用M- 0-4 管理 buffer
(global-set-key (kbd "s-2") 'other-window)
(global-set-key (kbd "s-`") 'delete-other-windows)
(global-set-key (kbd "s-1") 'split-window-horizontally)
;;(global-set-key (kbd "s-3") 'split-window-vertically)

; 立即关闭当前buffer
(defun yic-kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "C-x k") 'yic-kill-current-buffer)
(global-set-key (kbd "C-x C-k") 'yic-kill-current-buffer)

; 在 minibuffer 中显示当前 buffer 的文件路径
(defun display-buffer-name ()
  (interactive)
  (message (buffer-file-name (current-buffer))))
(global-set-key (kbd "M-n") 'display-buffer-name)

; 使用 M-; 时，如果没有区域被选中且光标不在行尾，直接注释掉当前行
(defun qiang-comment-dwim-line (&optional arg)
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region
       (line-beginning-position)
       (line-end-position))
    (comment-dwim arg)))
(global-set-key (kbd "M-;") 'qiang-comment-dwim-line)

;; 切换 buffer tabbar
;; (global-set-key (kbd "<M-up>") 'tabbar-backward-group)
;; (global-set-key (kbd "<M-down>") 'tabbar-forward-group)
;; (global-set-key (kbd "<M-left>") 'tabbar-backward)
;; (global-set-key (kbd "<M-right>") 'tabbar-forward)


;; C-x
;;======================================================================

;; 设置是否显示行号
(global-set-key (kbd "C-x N") 'linum-mode)

;; 找到鼠标指针当前所在的文件，返回到minibuffer中已供打开
(global-set-key (kbd "C-x f") 'find-file-at-point)

;; 跳转到当前 buffer 的 Dired 目录
(global-set-key (kbd "C-x C-j") 'dired-jump)

;; ibuffer
;; (require 'bs)
;; (global-set-key (kbd "M-s M-s") 'bs-show)
;; (global-set-key (kbd "M-s M-s") 'ibuffer)

(global-set-key (kbd "C-x C-x" ) 'ido-switch-buffer)
(global-set-key (kbd "C-x C-b" ) 'ido-switch-buffer)

;; C-c
;;======================================================================

;; 查询天气
(require 'cn-weather)
(setq cn-weather-city "上海")
(global-set-key (kbd "C-c e") 'cn-weather)

;; 调用 stardict 的命令行接口来查辞典
;; 如果选中了 region 就查询 region 的内容，否则就查询当前光标所在的词
;; (defun kid-star-dict ()
;;   (interactive)
;;   (let ((begin (point-min))
;;         (end (point-max)))
;;     (if mark-active
;;         (setq begin (region-beginning)
;;               end (region-end))
;;       (save-excursion
;;         (backward-word)
;;         (mark-word)
;;         (setq begin (region-beginning)
;;               end (region-end))))
;;     ;; 有时候 stardict 会很慢，所以在回显区显示一点东西
;;     ;; 以免觉得 Emacs 在干什么其他奇怪的事情。
;;     (message "searching for %s ..." (buffer-substring begin end))
;;     (tooltip-show
;;      (shell-command-to-string
;;       (concat "sdcv -n "
;;               (buffer-substring begin end))) nil)))
;; (global-set-key (kbd "C-c d") 'kid-star-dict)

;; 插入当前时间
;; (defun my-insert-datetime ()
;;   (interactive)
;;   (insert (format-time-string "%Y/%m/%d %H:%M:%S" (current-time))))
;; (global-set-key (kbd "C-c C-t") 'my-insert-datetime)

;; f1-f12 mouse settings
;;======================================================================

;; 切换全屏显示
;; (global-set-key (kbd "<f11>") 'my-fullscreen)

(windmove-default-keybindings 'meta)

(setq winner-dont-bind-my-keys t)
(winner-mode t)
(global-set-key (kbd "<f11> C-z") 'winner-undo)
(global-set-key (kbd "<f11> C-y") 'winner-redo)

; 使用鼠标滚轮翻页时，一次只翻3行
;; (defun up-slightly () (interactive) (scroll-up 3))
;; (defun down-slightly () (interactive) (scroll-down 3))
;; (global-set-key [mouse-4] 'down-slightly)
;; (global-set-key [mouse-5] 'up-slightly)

(global-set-key [mouse-4] 'scroll-down-1)
(global-set-key [mouse-5] 'scroll-up-1)

;; add trans to selected html word
(global-set-key (kbd "C-c C-t") 'django-insert-trans)


;; (global-set-key (kbd "C-c C-t") 'django-insert-transpy)