;;statict(sdcv)
;; author: pluskid
;; 调用 stardict 的命令行接口来查辞典
;; 如果选中了 region 就查询 region 的内容，否则就查询当前光标所在的词

(defun kid-star-dict ()
  (interactive)
  (let ((begin (point-min))
        (end (point-max)))
    (if mark-active
        (setq begin (region-beginning)
              end (region-end))
      (save-excursion
        (backward-word)
        (mark-word)
        (setq begin (region-beginning)
              end (region-end))))
    ;; 有时候 stardict 会很慢，所以在回显区显示一点东西
    ;; 以免觉得 Emacs 在干什么其他奇怪的事情。
    (message "searching for %s ..." (buffer-substring begin end))
    (tooltip-show
     (shell-command-to-string
      (concat "sdcv -n "
              (buffer-substring begin end))) nil))
)