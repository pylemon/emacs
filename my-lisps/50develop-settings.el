;; -------~-------~--~------------------~------------------------~------
;; DEVELOP SETTINGS
;; -------~-------~--~------------------~------------------------~------

(require 'eval-after-load)

;; 所有关于lisp方面的配置
(require 'all-lisp-settings)

;; html配置
(require 'html-mode-settings)

;; 自动给你加上括号
;; 比较麻烦 经常会画蛇添足 关掉吧 尽量习惯过来
;; (require 'autopair-settings)

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

;; trac-wiki mode #TODO not working
;; (require 'trac-wiki)
;; (trac-wiki-define-project "pylemon"
;; 			  "http://127.0.0.1:8000/trac/" t)

;; using gist in emacs
(require 'gist)
(setq gist-view-gist t)

;; using projectile 可以grep项目,快速定位文件
(require 'projectile)
(projectile-global-mode) ;; to enable in all buffers
(setq projectile-enable-caching t)



;; emacs-nav
(setq dotfiles-dir (file-name-directory
                    (or load-file-name (buffer-file-name))))

(add-to-list 'load-path
             (expand-file-name "emacs-nav"
                               (expand-file-name "src" dotfiles-dir)))
(require 'nav)
;; (defadvice nav-in-place (before my-nav-in-other-window)
;;   "Start Nav in the other window, after splitting."
;;   (other-window 1))
;; (ad-activate 'nav-in-place)



;; pylint
(require 'python-pylint)
(add-hook 'python-mode-hook '(lambda ()
          (local-set-key (kbd "C-c m l") 'python-pylint)
))

(autoload 'python-pep8 "python-pep8")
(autoload 'pep8 "python-pep8")


