;; -------~-------~--~------------------~------------------------~------
;; DEVELOP SETTINGS
;; -------~-------~--~------------------~------------------------~------

(require 'eval-after-load)

;; 所有关于lisp方面的配置
(require 'all-lisp-settings)

;; html配置
(require 'html-mode-settings)

;; 自动给你加上括号
(require 'autopair-settings)

;; 所有关于括号的配置
(require 'all-paren-settings)

;; ;; 自动补全的配置
(require 'yasnippet)
(setq yas/root-directory "~/em/lisps/snippets")
(yas/load-directory yas/root-directory)
(yas/global-mode 1)
(require 'auto-complete-config)
(ac-config-default)


;; 各种 mode
;; -------~-------~--~------------------~------------------------~------

;; markdown mode
(require 'markdown-mode)

;; lua mode
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

;; javascript mode
(require 'javascript-mode)
(autoload 'javascript-mode "JavaScript" nil t)


;; mode list
;; -------~-------~--~------------------~------------------------~------
(add-to-list 'auto-mode-alist '("\\.mkd$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))



;; multi-term 终端
(require 'multi-term)
(setq multi-term-program "/bin/zsh")
(setq multi-term-buffer-name "shell")
(setq multi-term-dedicated-select-after-open-p t)

;; 错误检查
;; (require 'flymake-settings)


(autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

(add-hook 'javascript-mode-hook 'javascript-custom-setup)
(defun javascript-custom-setup ()
  (moz-minor-mode 1))