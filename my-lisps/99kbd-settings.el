;; 功能:
;; 设置所有键盘绑定相关的东东
;;
;; 修改时间:
;; 2011年12月12日


;; <C-?>
;;======================================================================

;; 切换 buffer 向前向后
(global-set-key (kbd "<C-tab>") 'wcy-switch-buffer-forward)
(global-set-key (kbd "<C-`>") 'wcy-switch-buffer-backward)

;; 更改设置标记 Mark set
(global-unset-key (kbd "<C-SPC>"))
(global-set-key (kbd "<s-SPC>") 'set-mark-command)

;; ibus 输入法切换
(global-set-key (kbd "<C-SPC>") 'ibus-toggle)


;; <M-?>
;;======================================================================

;; 使用M-0 - 4 管理 buffer
(global-set-key (kbd "M-0") 'other-window)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'wcy-switch-buffer-backward)
(global-set-key (kbd "M-3") 'wcy-switch-buffer-forward)
(global-set-key (kbd "M-4") 'yic-kill-current-buffer)

;; 在 minibuffer 中显示当前 buffer 的文件路径
(global-set-key (kbd "M-5") 'display-buffer-name)

;; 当没有mark，且光标不再行尾时， M-; 注释当前行
(global-set-key (kbd "M-;") 'qiang-comment-dwim-line)

;; 切换 buffer tabbar 
(global-set-key (kbd "<M-up>") 'tabbar-backward-group)
(global-set-key (kbd "<M-down>") 'tabbar-forward-group)
(global-set-key (kbd "<M-left>") 'tabbar-backward)
(global-set-key (kbd "<M-right>") 'tabbar-forward)


;; C-x
;;======================================================================

;; 设置是否显示行号
(global-set-key (kbd "C-x N") 'linum-mode)

;; 找到鼠标指针当前所在的文件，返回到minibuffer中已供打开
(global-set-key (kbd "C-x f") 'find-file-at-point)

;; 跳转到当前 buffer 的 Dired 目录
(global-set-key (kbd "C-x C-j") 'dired-jump)

;; C-c
;;======================================================================

;; 查询天气
(global-set-key (kbd "C-c C-w") 'cn-weather)

;; 查询单词
(global-set-key (kbd "C-c C-d") 'kid-star-dict)


;; f1-f12 mouse settings
;;======================================================================

;; 切换全屏显示
(global-set-key (kbd "<f11>") 'my-fullscreen)

(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly) 

