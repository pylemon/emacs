;; emacs load-path and requirements
(add-to-list 'load-path "~/emacs/lisps/")
(require 'bookmark)
(require 'tomorrow-night-theme)
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


;; basic settings
;; use y/n to confirm
(fset 'yes-or-no-p 'y-or-n-p)
;; trailling whitespace when save
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;; use middle mouse key to yank
(setq mouse-yank-at-point t)
;; use the x clipboard
(setq x-select-enable-clipboard t)
;; enable show paren mode
(show-paren-mode t)
;; rst-mode colortheme bugfix
(custom-set-variables '(rst-level-face-base-color "black"))
;; no backup files
(setq make-backup-files nil)
;; no autosave file like #filename#
(setq auto-save-default nil)
;; bookmark settings
(setq bookmark-default-file "~/emacs/bookmarks" bookmark-save-flag 1)
;; cua-mode for select text in a retangle area. start it with C-Return
(cua-mode t)
(cua-selection-mode t)


;; look and feel
;; show time on mode-line
(display-time-mode nil)
;; init message and scratch message
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
;; no tabbar toolbar
(menu-bar-mode -1)
(tool-bar-mode -1)
;; no scrollbar
(customize-set-variable 'scroll-bar-mode nil)
;; buffer indicate
(setq-default indicate-buffer-boundaries 'left)
;; tabbar settings
(tabbar-mode)
(set-face-attribute 'tabbar-default nil
		    :family "profont"
		    :background "#111111"
		    :foreground "#a0a0a0"
		    :height 0.9)
(set-face-attribute 'tabbar-button nil
		    :inherit 'tabbar-default
		    :box '(:line-width 1 :color "#111111"))
(set-face-attribute 'tabbar-selected nil
		    :inherit 'tabbar-default
		    :background "#111111"
		    :foreground "#1793d1"
		    :overline "#111111"
		    :underline nil
:box '(:line-width 1 :color "#1793d1"))
(set-face-attribute 'tabbar-unselected nil
		    :inherit 'tabbar-default
		    :overline "#111111"
		    :box '(:line-width 1 :color "#1793d1"))
(defun tabbar-buffer-groups () "tabbar group"
  (list (cond ((memq major-mode '(shell-mode dired-mode)) "shell")
	      ((memq major-mode '(c-mode c++-mode)) "cc")
	      ((string-equal "*" (substring (buffer-name) 0 1)) "emacs")
	      (t "other"))))
(setq tabbar-buffer-groups-function 'tabbar-buffer-groups)
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


;; programming
;; github gist settings
(setq gist-view-gist t)
;; lambda mode settings
(setq lambda-symbol (string (make-char 'greek-iso8859-7 107)))
(add-hook 'python-mode-hook 'lambda-mode 1)
(add-hook 'emacs-lisp-mode-hook 'lambda-mode 1)
;; auto-mode alist
(add-to-list 'auto-mode-alist '("\\.po$" . po-mode))


;; keybindings
;; tabbar-moving
(global-set-key (kbd "s-<up>") 'tabbar-backward-group)
(global-set-key (kbd "s-<down>") 'tabbar-forward-group)
(global-set-key (kbd "s-<left>") 'tabbar-backward)
(global-set-key (kbd "s-<right>") 'tabbar-forward)

;; kill current buffer
(defun yic-kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))
(global-set-key (kbd "M-`") 'yic-kill-current-buffer)

;; comment or uncomment region
(defun qiang-comment-dwim-line (&optional arg)
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region
       (line-beginning-position)
       (line-end-position))
    (comment-dwim arg)))
(global-set-key (kbd "M-;") 'qiang-comment-dwim-line)

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
(global-set-key (kbd "C-x f") 'ido-find-file)
(global-set-key (kbd "C-x C-f") 'ido-find-file)
(global-set-key (kbd "C-x n f") 'ido-find-file-other-frame)
(global-set-key (kbd "C-x C-d" ) 'ido-dired)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x p") 'pep8)

(global-set-key (kbd "<f2>") 'nav-in-place)
(global-set-key (kbd "<f3>") 'grep-find)
(global-set-key (kbd "<f5>") 'todo-show)
(global-set-key (kbd "<XF86WakeUp>") 'set-mark-command)
(global-set-key (kbd "C-\\") nil)


(provide 'my-emacs-config)
