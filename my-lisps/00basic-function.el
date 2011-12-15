(require 'util)
(require 'ahei-misc)
(require 'wcy-swbuff)

; 全屏函数
;;======================================================================

(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0)))

; 该函数用于最大化,状态值为1说明最大化后不会被还原因为这里有两次最大化 (分别是水平和垂直)
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

; 搜索设置
(defun isearch-settings ()
  "settings for `isearch'."
  ;; 在C-s进入incremental search的时候,按M-i,替换当前查找内容
  (defun isearch-query-replace-current ()
    "Replace current searching string."
    (interactive)
    (let ((case-fold-search isearch-case-fold-search)
          (from-string isearch-string))
      (if (string= from-string "")
          (isearch-update)
        (if (not isearch-success)
            (progn
              (message "Search string not found")
              (sleep-for 0.5)
              (isearch-update))
          (progn
            (isearch-done)
            (goto-char (min (point) isearch-other-end)))
          (perform-replace
           from-string
           (read-from-minibuffer
            (format "Query replace %s with: " from-string)
            "" nil nil query-replace-to-history-variable from-string t)
           t                                ; query flag
           isearch-regexp
           nil)))))

  ;; 搜索时不区分大小写
  (setq-default case-fold-search t)

  (defun toggle-case-fold-search-when-search ()
    "在搜索的时候执行`toggle-case-fold-search'."
    (interactive)
    (toggle-case-fold-search)
    (let ((str isearch-string))
      (goto-char isearch-opoint)
      (isearch-done)
      (let ((isearch-command
             (if isearch-forward
                 (if isearch-regexp 'isearch-forward-regexp 'isearch-forward)
               (if isearch-regexp 'isearch-backward-regexp 'isearch-backward))))
        (call-interactively isearch-command))
      (isearch-yank-string str)))

  (defun isearch-cur-word (fun)
    "ISearch current word use function FUN."
    (let ((cur-word (current-word)))
      (if (not cur-word)
          (message "No word under cursor.")
        (call-interactively fun)
        (isearch-yank-string cur-word))))

;;;###autoload
  (defun isearch-forward-cur-word (&optional backward)
    "`isearch-forward' current word."
    (interactive "P")
    (let ((fun (if backward 'isearch-backward 'isearch-forward)))
      (isearch-cur-word fun)))

  (define-key-list
    isearch-mode-map
    `(("M-i" isearch-query-replace-current-sb)
      ("M-k" isearch-clean)
      ("M-g" isearch-cancel)
      ("M-u" isearch-toggle-word)
      ("M-y" isearch-yank-line)
      ("C-y" isearch-yank-kill)
      ("M-h" isearch-del-char)
      ("M-H" ,(if is-after-emacs-23 isearch-help-map 'isearch-mode-help))))

  (defun isearch-clean ()
    "Clean string in `iserch-mode'."
    (interactive)
    (goto-char isearch-opoint)
    (let ((isearch-command
           (if isearch-forward
               (if isearch-regexp 'isearch-forward-regexp 'isearch-forward)
             (if isearch-regexp 'isearch-backward-regexp 'isearch-backward))))
      (call-interactively isearch-command))))

(define-key-list
    global-map
    `(("C-x M-s" isearch-forward-cur-word)))



;; 编码设置
;;======================================================================
;; mule-gbk
(unless is-after-emacs-23
  (require 'mule-gbk "my-mule-gbk"))

;; 设置默认编码
(when (not (and is-after-emacs-23 window-system))
  (set-language-environment "UTF-8"))
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

(defun revert-buffer-with-coding-system-no-confirm (coding-system)
  "Call `revert-buffer-with-coding-system', but when `revert-buffer' do not need confirm."
  (interactive "zCoding system for visited file (default nil): ")
  (let ((coding-system-for-read coding-system))
    (revert-buffer-no-confirm)))

(defun revert-buffer-with-gbk ()
  "Call `revert-buffer-with-coding-system-no-confirm' with gbk."
  (interactive)
  (revert-buffer-with-coding-system-no-confirm 'gbk))


;; basic functions
;; ======================================================================

; 使用鼠标滚轮翻页时，一次只翻3行
(defun up-slightly () (interactive) (scroll-up 3))
(defun down-slightly () (interactive) (scroll-down 3))

; 显示当前buffer的路径，绑定到 M-5
(defun display-buffer-name ()
  (interactive)
  (message (buffer-file-name (current-buffer))))

; 立即关闭当前buffer,不需要确认，绑定到 M-4
(defun yic-kill-current-buffer ()
  "Kill current buffer."
  (interactive)
  (kill-buffer (current-buffer)))

; 使用 M-; 时，如果没有区域被选中且光标不在行尾，直接注释掉当前行
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
