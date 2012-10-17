;; emacs load-path and requirements
(add-to-list 'load-path "~/emacs/lisps/")
(require 'tomorrow-night-theme)
(require 'bookmark)
(require 'tabbar)
(require 'uniquify)
(require 'linum+)
(require 'rainbow-mode)
(require 'psvn)
(require 'magit)
(require 'git-blame)
(require 'nav)
(require 'gist)
(require 'lua-mode)
(require 'markdown-mode)
(require 'javascript-mode)
(require 'po-mode)
(require 'lambda-mode)
(require 'idomenu)
(require 'ido)
(require 'wrap-it)
(require 'python-pep8)
(require 'yasnippet-settings)
(require 'tramp)
(require 'textmate)
(require 'weibo)

;; basic settings
;; use y/n to confirm
(fset 'yes-or-no-p 'y-or-n-p)
;; use middle mouse key to yank
(setq mouse-yank-at-point t)
;; use the x clipboard
;; 2012-04-22 in GNU Emacs 24.0.93.1, that var is set to t now.
;; (setq x-select-enable-clipboard t)
;; enable show paren mode
(show-paren-mode t)
;; rst-mode colortheme bugfix
(custom-set-variables '(rst-level-face-base-color "black"))
;; no backup files
(setq make-backup-files nil)
;; no autosave file like #filename#
(setq auto-save-default nil)
;; bookmark settings
(setq bookmark-default-file "~/Yunio/software_configs/bookmarks" bookmark-save-flag 1)
;; cua-mode for select text in a retangle area. start it with C-Return
(cua-mode t)
(cua-selection-mode t)
;; 给list-colors-display的颜色排序
(setq list-colors-sort 'hsv)
;; 设定默认的浏览器为 google-chrome
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")


;; look and feel
;; show filename and path at Frame Title
(setq frame-title-format "%f")
;; show time on mode-line
(display-time-mode nil)
;; show column number in modeline
(setq column-number-mode t)
;; init message and scratch message
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
;; no menubar toolbar
(menu-bar-mode -1)
(tool-bar-mode -1)
;; no scrollbar
(customize-set-variable 'scroll-bar-mode nil)
;; buffer indicate
(setq-default indicate-buffer-boundaries 'left)
;; tabbar settings
(tabbar-mode)
(setq tabbar-separator '(1.6))
(tabbar-mwheel-mode -1)
(dolist (btn '(tabbar-buffer-home-button
               tabbar-scroll-left-button
               tabbar-scroll-right-button))
  (set btn (cons (cons " " nil)
                 (cons " " nil))))
(set-face-attribute 'tabbar-default nil
		    :family "profont" ;;"微软雅黑Monaco"
		    :background "#111111"
		    :foreground "#cccccc"
		    :height 0.9)
(set-face-attribute 'tabbar-button nil
		    :inherit 'tabbar-default
		    :box '(:line-width 1 :color "#111111"))
(set-face-attribute 'tabbar-selected nil
		    :inherit 'tabbar-default
		    :background "#111111"
		    :foreground "#1793d1"
		    :overline nil
		    :underline nil
		    :box '(:line-width 1 :color "#111111"))
(set-face-attribute 'tabbar-unselected nil
		    :inherit 'tabbar-default
		    :overline nil
		    :underline nil
		    :box '(:line-width 1 :color "#111111"))
(set-face-attribute 'tabbar-separator nil
		    :height 1.0)
(defun tabbar-buffer-groups () "tabbar group"
  (list (cond ((string-equal "*scratch*" (buffer-name)) "emacs")
	      ((string-equal "*Messages*" (buffer-name)) "emacs")
	      ((string-equal "*Bookmark List*" (buffer-name)) "emacs")
	      ;; ((string-equal "*" (substring (buffer-name) 0 1)) "emacs")
	      ;; ((memq major-mode '(c-mode c++-mode)) "cc")
	      ;; ((memq major-mode '(shell-mode dired-mode)) "shell")
	      (t "other"))))
(setq tabbar-buffer-groups-function 'tabbar-buffer-groups)

(defun my-tabbar-buffer-help-on-tab (tab)
  "Return the help string shown when mouse is onto TAB."
  (if tabbar--buffer-show-groups
      (let* ((tabset (tabbar-tab-tabset tab))
             (tab (tabbar-selected-tab tabset)))
        (format "mouse-1: switch to buffer %S in group [%s]"
                (buffer-name (tabbar-tab-value tab)) tabset))
    (format "\
mouse-1: switch to buffer %S\n\
mouse-2: kill this buffer\n\
mouse-3: delete other windows"
            (buffer-name (tabbar-tab-value tab)))))

(defun my-tabbar-buffer-select-tab (event tab)
  "On mouse EVENT, select TAB."
  (let ((mouse-button (event-basic-type event))
        (buffer (tabbar-tab-value tab)))
    (cond
     ((eq mouse-button 'mouse-2)
      (with-current-buffer buffer
        (kill-buffer)))
     ((eq mouse-button 'mouse-3)
      (delete-other-windows))
     (t
      (switch-to-buffer buffer)))
    ;; Don't show groups.
    (tabbar-buffer-show-groups nil)))

(setq tabbar-help-on-tab-function 'my-tabbar-buffer-help-on-tab)
(setq tabbar-select-tab-function 'my-tabbar-buffer-select-tab)

;; uniquify buffer names
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)
(setq uniquify-ignore-buffers-re "^\\*")
;; linum mode
(setq linum-format '("%%%dd|"))
(add-hook 'text-mode-hook 'linum-mode)
(add-hook 'emacs-lisp-mode-hook 'linum-mode)
(add-hook 'html-mode-hook 'linum-mode)
(add-hook 'python-mode-hook 'linum-mode)
;; rainbow-mode
(add-hook 'emacs-lisp-mode-hook 'rainbow-mode)
(add-hook 'css-mode-hook 'rainbow-mode)
(add-hook 'x-resource-generic-mode-hook 'rainbow-mode)
;; remove-dos-eo
(defun remove-dos-eo ()
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))
(add-hook 'python-mode-hook 'remove-dos-eo)
(add-hook 'javascript-mode-hook 'remove-dos-eo)
(add-hook 'html-mode-hook 'remove-dos-eo)
(add-hook 'css-mode-hook 'remove-dos-eo)
(add-hook 'diff-mode-hook 'remove-dos-eo)
;;
;; 进入 incremental search mode 之后，有些命令可以根据光标所在位置补全要查找内容，
;; 例如 C-w 可以补全一个词。但是如果按多了 C-w 就不能回退了，而且不能精确定位，
;; 下面的键绑定重新定义了一些常用的光标移动命令，根据光标移动，自动补齐查找内容，
;; 例如 C-f 自动补齐光标处的一个字符。
;; (define-key isearch-mode-map (kbd "C-e") 'isearch-move-point)
;; (define-key isearch-mode-map (kbd "C-a") 'isearch-move-point)
;; (define-key isearch-mode-map (kbd "M-e") 'isearch-move-point)
;; (define-key isearch-mode-map (kbd "M-a") 'isearch-move-point)
;; (define-key isearch-mode-map (kbd "C-M-e") 'isearch-move-point)
;; (define-key isearch-mode-map (kbd "C-M-a") 'isearch-move-point)
(define-key isearch-mode-map (kbd "C-f") 'isearch-move-point)
(define-key isearch-mode-map (kbd "C-b") 'isearch-move-point)
;; (define-key isearch-mode-map (kbd "M-f") 'isearch-move-point)
;; (define-key isearch-mode-map (kbd "M-b") 'isearch-move-point)
;; (define-key isearch-mode-map (kbd "C-M-f") 'isearch-move-point)
;; (define-key isearch-mode-map (kbd "C-M-b") 'isearch-move-point)
(defun isearch-move-point ()
  (interactive)
  (when isearch-success
    (save-excursion
      (let ((overriding-terminal-local-map nil)
            (old-point (or isearch-other-end (point))))
        (call-interactively (key-binding (this-command-keys)))
        (setq isearch-string (buffer-substring-no-properties  old-point
                                                              (point))
              isearch-message
              (mapconcat 'isearch-text-char-description
                         isearch-string "")
              ;; Don't move cursor in reverse search.
              isearch-forward (cond
                               ((< old-point (point)) t)
                               ((> old-point (point)) nil)
                               ((= old-point (point)) isearch-forward))
              )))
    (isearch-search-and-update)))

;; 一个 macro ， 可以方便的定义这种双重绑定，也就是，在 mark-active 时运行 一个函数，否则运行另一个函数。
(defmacro wcy-define-2bind-transient-mode (funname cmd-mark-active
                                                   cmd-mark-no-active)
  `(defun ,funname ()
     (interactive)
     (if mark-active
         (call-interactively ,cmd-mark-active)
       (call-interactively ,cmd-mark-no-active))))

;; 和 bash 中的类似的快键，不用再按 backspace 了。
(global-set-key  (kbd "C-w") 'wcy-backward-kill-word-or-kill-region)
(wcy-define-2bind-transient-mode
 wcy-backward-kill-word-or-kill-region
 'kill-region
 'backward-kill-word)

;; 更加强大的 dired-x
;; Load Dired X when Dired is loaded.
(add-hook 'dired-load-hook '(lambda () (require 'dired-x)))
;; Enable toggling of uninteresting files.
(setq dired-omit-files-p t)



;; programming
;; trailling whitespace when save
(add-hook 'c-mode-hook (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))
(add-hook 'python-mode-hook (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))
;; enable textmate mode
(textmate-mode)
;; autocomplete in orgmode
(define-key ac-complete-mode-map [tab] 'ac-expand)
;; github gist settings
(setq gist-view-gist t)
;; electric-pair-mode
(electric-pair-mode)
;; lambda mode settings
(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))
(add-hook 'python-mode-hook 'lambda-mode 1)
(add-hook 'emacs-lisp-mode-hook 'lambda-mode 1)
;; auto-mode alist
(add-to-list 'auto-mode-alist '("\\.po$" . po-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . gfm-mode))
;; auto insert template when create a new file
;; (define-auto-insert 'python-mode  "~/emacs/snippets/templates/python.tpl" )
;; 上面这个方法不知道怎么定义光标的位置
(define-auto-insert 'python-mode '(nil "#!/usr/bin/env python\n# -*- coding: utf-8 -*-\n\n"))
(define-auto-insert 'sh-mode '(nil "#!/bin/bash\n\n"))
(add-hook 'find-file-hooks 'auto-insert)
(setq auto-insert-query nil)
;; ack-grep settings
(setq ack-executable (executable-find "ack-grep"))
(autoload 'ack-same "full-ack" nil t)
(autoload 'ack "full-ack" nil t)
(autoload 'ack-find-same-file "full-ack" nil t)
(autoload 'ack-find-file "full-ack" nil t)

;; PDFs visited in Org-mode are opened in Evince (and other file extensions are handled according to the defaults)
(add-hook 'org-mode-hook
      '(lambda ()
         (setq org-file-apps
           '((auto-mode . emacs)
             ("\\.mm\\'" . default)
             ("\\.x?html?\\'" . default)
             ("\\.pdf\\'" . "evince %s")
	     ("\\.rmvb\\'" . "mplayer %s")
	     ("\\.png\\'" . "feh %s")
))))


;; keybindings
;; tabbar-moving
;; (global-set-key (kbd "s-<up>") 'tabbar-backward-group)
;; (global-set-key (kbd "s-<down>") 'tabbar-forward-group)
(global-set-key (kbd "s-<left>") 'tabbar-backward)
(global-set-key (kbd "s-<right>") 'tabbar-forward)

;; weibo
(global-set-key (kbd "<f12>") 'weibo-timeline)

;; kill current buffer
(defun yic-kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "M-`") 'yic-kill-current-buffer)

;; copy to clipboard
(global-set-key (kbd "M-w") 'clipboard-kill-ring-save)

;; wrap-it
(global-set-key (kbd "C-'") 'wrap-word-quote)
(global-set-key (kbd "C-M-'") 'wrap-word)

;; other buffer
(defun switch-to-other-buffer ()
  "switch to recent edit buffer"
  (interactive)
  (switch-to-buffer (other-buffer)))
(global-set-key (kbd "C-c o") 'switch-to-other-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "C-c q") 'join-line)

(global-set-key (kbd "C-x 2") 'split-window-horizontally)
(global-set-key (kbd "C-x 3") 'split-window-vertically)
(global-set-key (kbd "C-x C-r") 'bookmark-bmenu-list)

;; ido and idomenu
(global-set-key (kbd "C-x C-i") 'idomenu)
(ido-mode t)
(ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-auto-merge-work-directories-length -1)
(global-set-key (kbd "C-x C-x" ) 'ido-switch-buffer)
(global-set-key (kbd "C-x f") 'ack-find-file)
(global-set-key (kbd "C-x C-f") 'ido-find-file)
(global-set-key (kbd "C-x n f") 'ido-find-file-other-frame)
(global-set-key (kbd "C-x C-d" ) 'ido-dired)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x p") 'pep8)

;; (global-set-key (kbd "<f2>") 'nav-in-place)
;; f3 is for marcos
;; (global-set-key (kbd "<f3>") 'grep-find)
(global-set-key (kbd "<f10>") 'todo-show)
(global-set-key (kbd "<XF86WakeUp>") 'set-mark-command)
(global-set-key (kbd "C-\\") nil)

;; (global-set-key  [A-return] 'textmate-next-line)
;; (global-set-key  (kbd "A-M-t") 'textmate-clear-cache)
;; (global-set-key  (kbd "A-M-]") 'align)
;; (global-set-key  (kbd "A-M-[") 'indent-according-to-mode)
;; (global-set-key  (kbd "A-]")  'textmate-shift-right)
;; (global-set-key  (kbd "A-[") 'textmate-shift-left)
(global-set-key  (kbd "M-;") 'comment-or-uncomment-region-or-line)
;; (global-set-key  (kbd "A-L") 'textmate-select-line)
;; (global-set-key  (kbd "A-t") 'textmate-goto-file)
;; (global-set-key  (kbd "A-T") 'textmate-goto-symbol)
(global-set-key  (kbd "M-<up>") 'textmate-column-up)
(global-set-key  (kbd "M-<down>") 'textmate-column-down)
(global-set-key  (kbd "M-S-<up>") 'textmate-column-up-with-select)
(global-set-key  (kbd "M-S-<down>") 'textmate-column-down-with-select)


(provide 'my-emacs-config)
