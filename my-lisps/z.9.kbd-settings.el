;; 功能: 设置所有键盘绑定相关的东东

;; 查询天气
(global-set-key (kbd "C-c C-w") 'cn-weather)

;; 标记 Mark set
(global-unset-key (kbd "C-SPC"))
(global-set-key (kbd "s-SPC") 'set-mark-command)

;; ibus 输入法切换
(global-set-key (kbd "C-SPC") 'ibus-toggle)

;; 切换 buffer 向前向后
(global-set-key (kbd "<C-tab>") 'wcy-switch-buffer-forward)
(global-set-key (kbd "C-`") 'wcy-switch-buffer-backward)
