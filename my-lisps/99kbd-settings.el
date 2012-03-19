;; -------~-------~--~------------------~------------------------~------
;; key bindings
;; -------~-------~--~------------------~------------------------~------

;; 平滑滚动
(require 'smooth-scroll)

;; 切换 buffer 向前向后
(require 'wcy-swbuff)
(setq wcy-switch-buffer-active-buffer-face  'highlight)
(setq wcy-switch-buffer-inactive-buffer-face  'secondary-selection )

; 在 minibuffer 中显示当前 buffer 的文件路径
(defun display-buffer-name ()
  (interactive)
  (message (buffer-file-name (current-buffer)))
)

; 使用 M-; 时，如果没有区域被选中且光标不在行尾，直接注释掉当前行
(defun qiang-comment-dwim-line (&optional arg)
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region
       (line-beginning-position)
       (line-end-position))
    (comment-dwim arg))
)

;; M-w 复制到剪切板和 kill-ring 'clickboard-kill-ring-save

; 立即关闭当前buffer
(defun yic-kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

;; 管理 window
(windmove-default-keybindings 'meta)
(setq winner-dont-bind-my-keys t)
(winner-mode t)

;; 查询天气
(require 'cn-weather)
(setq cn-weather-city "上海")
(cn-weather)


;; "M-?"
;; -------~-------~--~------------------~------------------------~------
(global-set-key (kbd "M-<tab>") 'wcy-switch-buffer-forward)
;; (global-set-key (kbd "M-`") 'wcy-switch-buffer-backward)
(global-set-key (kbd "M-`") 'yic-kill-current-buffer)
(global-set-key (kbd "M-w") 'clipboard-kill-ring-save)
(global-set-key (kbd "M-n") 'display-buffer-name)
(global-set-key (kbd "M-;") 'qiang-comment-dwim-line)
(global-set-key (kbd "M-<up>") 'tabbar-backward-group)
(global-set-key (kbd "M-<down>") 'tabbar-forward-group)
(global-set-key (kbd "M-<left>") 'tabbar-backward)
(global-set-key (kbd "M-<right>") 'tabbar-forward)


;; C-x
;; -------~-------~--~------------------~------------------------~------
(global-set-key (kbd "C-x <right>") 'winner-redo)
(global-set-key (kbd "C-x <left>") 'winner-undo)
(global-set-key (kbd "C-x 2") 'split-window-horizontally)
(global-set-key (kbd "C-x 3") 'split-window-vertically)
(global-set-key (kbd "C-x k") 'yic-kill-current-buffer)
(global-set-key (kbd "C-x C-k") 'yic-kill-current-buffer)
(global-set-key (kbd "C-x N") 'linum-mode)
(global-set-key (kbd "C-x f") 'find-file-at-point)
(global-set-key (kbd "C-x C-j") 'dired-jump)
(global-set-key (kbd "C-x C-x" ) 'ido-switch-buffer)
(global-set-key (kbd "C-x C-b" ) 'ido-switch-buffer)


;; C-c
;; -------~-------~--~------------------~------------------------~------
(global-set-key (kbd "C-c C-w") 'cn-weather)


;; others
;; -------~-------~--~------------------~------------------------~------
(global-set-key (kbd "<C-SPC>") nil)
(global-set-key (kbd "<XF86WakeUp>") 'set-mark-command)
(global-set-key [mouse-4] 'scroll-down-1)
(global-set-key [mouse-5] 'scroll-up-1)
