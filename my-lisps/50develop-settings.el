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
(setq yas/root-directory "~/emacs/lisps/snippets")
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


;; 需要 apt-get install python-mode
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(require 'ipython)

;; anything 补全 ipython 以及 python 代码
(require 'anything)
(require 'anything-ipython)
(when (require 'anything-show-completion nil t)
   (use-anything-show-completion 'anything-ipython-complete
                                 '(length initial-pattern)))

;; high-light ipdb breakpoint, C-c C-t to setup breakpoint
(defun annotate-pdb ()
  (interactive)
  (highlight-lines-matching-regexp "import ipdb")
  (highlight-lines-matching-regexp "ipdb.set_trace()"))
(add-hook 'python-mode-hook 'annotate-pdb)
(defun python-add-breakpoint ()
  (interactive)
  (py-newline-and-indent)
  (insert "import ipdb; ipdb.set_trace()")
  (highlight-lines-matching-regexp "^[ 	]*import ipdb; ipdb.set_trace()"))
;;(define-key py-mode-map (kbd "C-c C-t") 'python-add-breakpoint)

;; Comint uses M-up and M-down cycle backwards and forward through input history.
(require 'comint)
(define-key comint-mode-map (kbd "M-") 'comint-next-input)
(define-key comint-mode-map (kbd "M-") 'comint-previous-input)
(define-key comint-mode-map [down] 'comint-next-matching-input-from-input)
(define-key comint-mode-map [up] 'comint-previous-matching-input-from-input)

;; pylint
(require 'python-pylint)
(add-hook 'python-mode-hook '(lambda ()
          (local-set-key (kbd "C-c m l") 'python-pylint)
))
(autoload 'python-pep8 "python-pep8")
(autoload 'pep8 "python-pep8")

;; display a lambda character (λ) when you type lambda
(require 'lambda-mode)
(add-hook 'python-mode-hook #'lambda-mode 1)
(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))


;;emacs helm instead of anything.el
(add-to-list 'load-path "/home/liwei/resp/helm")
(require 'helm-config)
(helm-mode 1)

;; show buffer total line number or region line numbers
(which-function-mode t)
(defun count-brf-lines (&optional is-fun)
  "显示当前buffer或region或函数的行数和字符数"
  (interactive "P")
  (let (min max)
    (if is-fun
        (save-excursion
          (beginning-of-defun) (setq min (point))
          (end-of-defun) (setq max (point))
          (message "当前函数%s内共有%d行, %d个字符" (which-function) (count-lines min max) (- max min)))
      (if mark-active
          (progn
            (setq min (min (point) (mark)))
            (setq max (max (point) (mark))))
        (setq min (point-min))
        (setq max (point-max)))
      (if (or (= 1 (point-min)) mark-active)
          (if mark-active
              (message "当前region内共有%d行, %d个字符" (count-lines min max) (- max min))
            (message "当前buffer内共有%d行, %d个字符" (count-lines min max) (- max min)))
        (let ((nmin min) (nmax max))
          (save-excursion
            (save-restriction
              (widen)
              (setq min (point-min))
              (setq max (point-max))))
          (message "narrow下buffer内共有%d行, %d个字符, 非narrow下buffer内共有%d行, %d个字符"
                   (count-lines nmin nmax) (- nmax nmin) (count-lines min max) (- max min)))))))
(eal-define-keys-commonly
 global-map
 `(("C-x l" count-brf-lines)
   ("C-x L" (lambda () (interactive) (count-brf-lines t)))))