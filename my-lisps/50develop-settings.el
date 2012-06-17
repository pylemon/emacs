;; -------~-------~--~------------------~------------------------~------
;; DEVELOP SETTINGS
;; -------~-------~--~------------------~------------------------~------

(require 'eval-after-load)

;; subversion
(require 'psvn)

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
(setq yas/root-directory "~/emacs/lisps/snippets")
(yas/load-directory yas/root-directory)
(yas/global-mode 1)
(require 'auto-complete-config)
(ac-config-default)

(defface ac-yasnippet-candidate-face
  '((t (:background "sandybrown" :foreground "black")))
  "Face for yasnippet candidate.")
(defface ac-yasnippet-selection-face
  '((t (:background "coral3" :foreground "white")))
  "Face for the yasnippet selected candidate.")
(defvar ac-source-yasnippet
  '((candidates . ac-yasnippet-candidate)
    (action . yas/expand)
    (candidate-face . ac-yasnippet-candidate-face)
    (selection-face . ac-yasnippet-selection-face))
  "Source for Yasnippet.")


;; 各种 mode
;; -------~-------~--~------------------~------------------------~------

;; markdown mode
(require 'markdown-mode)

;; lua mode
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

;; javascript mode
(require 'javascript-mode)
(autoload 'javascript-mode "JavaScript" nil t)

;; (require 'po-mode+)
;; (autoload 'po-mode "po-mode+"
;;   "Major mode for translators to edit PO files" t)

;; mode list
;; -------~-------~--~------------------~------------------------~------
(add-to-list 'auto-mode-alist '("\\.mkd$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . javascript-mode))

;; multi-term 终端
(require 'multi-term)
(setq multi-term-program "bash")
(setq multi-term-buffer-name "shell")
(setq multi-term-dedicated-select-after-open-p t)

;; using gist in emacs
(require 'gist)
(setq gist-view-gist t)

;; using projectile 可以grep项目,快速定位文件
;; (require 'projectile)
;; (projectile-global-mode) ;; to enable in all buffers
;; (setq projectile-enable-caching t)

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
;; (require 'python-mode)
;; (add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))

(add-to-list 'auto-mode-alist '("\\.txt\\'" . rst-mode))

;; (require 'ipython)

;; anything 补全 ipython 以及 python 代码
(require 'anything)
;; (require 'anything-ipython)
(when (require 'anything-show-completion nil t)
   (use-anything-show-completion 'anything-ipython-complete
                                 '(length initial-pattern)))

;; high-light ipdb breakpoint, C-c C-t to setup breakpoint
;(defun annotate-pdb ()
;  (interactive)
;  (highlight-lines-matching-regexp "import ipdb")
;  (highlight-lines-matching-regexp "ipdb.set_trace()"))
;(add-hook 'python-mode-hook 'annotate-pdb)
;(defun python-add-breakpoint ()
;  (interactive)
;  (py-newline-and-indent)
;  (insert "import ipdb; ipdb.set_trace()")
;  (highlight-lines-matching-regexp "^[ 	]*import ipdb; ipdb.set_trace()"))
;(define-key py-mode-map (kbd "C-c C-t") 'python-add-breakpoint)

;; Comint uses M-up and M-down cycle backwards and forward through input history.
;; (require 'comint)
;; (define-key comint-mode-map (kbd "M-") 'comint-next-input)
;; (define-key comint-mode-map (kbd "M-") 'comint-previous-input)
;; (define-key comint-mode-map [down] 'comint-next-matching-input-from-input)
;; (define-key comint-mode-map [up] 'comint-previous-matching-input-from-input)

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
;; (add-to-list 'load-path "/home/liwei/resp/helm")
;; (require 'helm-config)
;; (helm-mode 1)

;; 错误检查
;; (require 'flymake-settings)

