;; -------~-------~--~------------------~------------------------~------
;; DEVELOP SETTINGS
;; -------~-------~--~------------------~------------------------~------

(require 'eval-after-load)

;; 错误检查
(require 'flymake-settings)

;; 所有关于lisp方面的配置
(require 'all-lisp-settings)

;; html配置
(require 'html-mode-settings)

;; 自动给你加上括号
(require 'autopair-settings)

;; 所有关于括号的配置
(require 'all-paren-settings)

;; 自动补全的配置
(require 'yasnippet)
(setq yas/root-directory "~/em/lisps/snippets")
(yas/load-directory yas/root-directory)
(yas/global-mode 1)
(require 'auto-complete-config)
(require 'auto-complete+)


;; 各种 mode
;; -------~-------~--~------------------~------------------------~------

;; markdown mode
(require 'markdown-mode)

;; lua mode
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

;; js2-mode
(autoload 'js2-mode "js2" nil t)
(setq js2-basic-offset 2)


;; mode list
;; -------~-------~--~------------------~------------------------~------
(add-to-list 'auto-mode-alist '("\\.mkd$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js-mode))