;; 功能:
;; python开发相关配置
;;
;; 修改时间:
;; 2012年1月6日

;; 所有关于括号的配置
(require 'all-paren-settings)

;; 用来显示当前光标在哪个函数
(require 'which-func-settings)

;; 像Eclipse那样高亮光标处单词
(require 'highlight-symbol-settings)

;; subversion
(require 'svn-settings)

;; 所有的自动补全的配置
(require 'all-auto-complete-settings)

;; 所有关于lisp方面的配置
(require 'all-lisp-settings)

;; html配置
(require 'html-mode-settings)

;; 自动给你加上括号
(require 'autopair-settings)

;; markdown 模式
(require 'markdown-mode)

(add-to-list 'auto-mode-alist '("\\.mkd$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))

(eal-define-keys
 'markdown-mode-map
 `(("C-c M-h" markdown)
   ("C-c M-b" markdown-preview)))

(defun markdown-mode-settings ()
  "Settings for `markdown-mode'.")

(eval-after-load "markdown-mode"
  `(markdown-mode-settings))

;; lua mode
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))


;; uniquify changes conflicting buffer names from file<2> etc
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t) ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers