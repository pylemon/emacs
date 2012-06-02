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

(defun reset-default-font ()
  (interactive)
(set-default-font "微软雅黑Monaco:pixelsize=12"))

;; 管理 window
(windmove-default-keybindings 'meta)
(setq winner-dont-bind-my-keys t)
(winner-mode t)

(reset-default-font)

(require 'wb-line-number)

;; 查询天气
;; (require 'cn-weather)
;; (setq cn-weather-city "上海")
;; (cn-weather)

;; "M-?"
;; -------~-------~--~------------------~------------------------~------
(global-set-key (kbd "s-<up>") 'tabbar-backward-group)
(global-set-key (kbd "s-<down>") 'tabbar-forward-group)
(global-set-key (kbd "s-<left>") 'tabbar-backward)
(global-set-key (kbd "s-<right>") 'tabbar-forward)
(global-set-key (kbd "M-`") 'yic-kill-current-buffer)
(global-set-key (kbd "M-<tab>") 'wcy-switch-buffer-backward)
;; (global-set-key (kbd "M-<right>") 'wcy-switch-buffer-forward)

(global-set-key (kbd "M-w") 'clipboard-kill-ring-save)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-;") 'qiang-comment-dwim-line)

;; C-x
;; -------~-------~--~------------------~------------------------~------
(global-set-key (kbd "C-x 2") 'split-window-horizontally)
(global-set-key (kbd "C-x 3") 'split-window-vertically)
(global-set-key (kbd "C-x k") 'yic-kill-current-buffer)
(global-set-key (kbd "C-x C-k") 'yic-kill-current-buffer)
(global-set-key (kbd "C-x N") 'wb-line-number-toggle)
(global-set-key (kbd "C-x m") 'reset-default-font)
(global-set-key (kbd "C-x n f") 'ido-find-file-other-frame)
(global-set-key (kbd "C-x f") 'find-file-at-point)
(global-set-key (kbd "C-x C-b" ) 'ido-switch-buffer)
(global-set-key (kbd "C-x C-d" ) 'ido-dired)
(global-set-key (kbd "C-x C-j") 'dired-jump)
(global-set-key (kbd "C-x C-x" ) 'ibuffer)
(global-set-key (kbd "C-x f") 'ido-find-file)
(global-set-key (kbd "C-x C-f") 'ido-find-file)
(global-set-key (kbd "C-x C-r") 'bookmark-bmenu-list)



;; C-c
;; -------~-------~--~------------------~------------------------~------
;; (global-set-key (kbd "C-c C-w") 'cn-weather)
(global-set-key (kbd "C-c <right>") 'winner-redo)
(global-set-key (kbd "C-c <left>") 'winner-undo)
(global-set-key (kbd "C-c <RET>") 'cua-set-rectangle-mark)


;; others
;; -------~-------~--~------------------~------------------------~------
(global-set-key (kbd "C-<SPC>") nil)
(global-set-key (kbd "C-\\") nil)

(setq ansi-term-color-vector
      [unspecified "#000000" "#ce2c51" "#5FFB65" "#FFFD65"
		   "#0082FF" "#FF2180" "#57DCDB" "#FFFFFF"])


(global-set-key (kbd "<f1>") 'multi-term-dedicated-open)
(global-set-key (kbd "<f2>") 'nav-in-place)
(global-set-key (kbd "<f3>") 'grep-find)
(global-set-key (kbd "<f5>") 'todo-show)

(add-hook 'term-mode-hook (lambda ()
   (define-key term-raw-map (kbd "C-y") 'term-paste)))
(global-set-key (kbd "<XF86WakeUp>") 'set-mark-command)
(global-set-key [mouse-4] 'scroll-down-1)
(global-set-key [mouse-5] 'scroll-up-1)
