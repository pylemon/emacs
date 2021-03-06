
(delete-selection-mode t)  ;; delsel ensure: t
(electric-pair-mode t)
;; tabbar-ruler
;; paredit

(setq-default indent-tabs-mode nil)  ;; never tab
(setq-default tab-width 4)  ;; display tab 4 width

(setq-default c-basic-offset 4)

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed t) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

(cond
 ((eq system-type 'gnu/linux)
  (progn
    (setq ex/linux t)
    (setq ex/windows nil)
    (setq ex/macos nil)
    (setq ex/org-agenda-dir (expand-file-name "~/Dropbox/Docs/Org/agenda/"))
    (setq ex/dash-docset-dir (expand-file-name "~/Dropbox/Application/emacs/docset/"))))
 ((eq system-type 'darwin)
  (progn
    (setq ex/linux nil)
    (setq ex/windows nil)
    (setq ex/macos t)
    (setq ex/org-agenda-dir (expand-file-name "~/Dropbox/Docs/Org/agenda/"))
    (setq ex/dash-docset-dir (expand-file-name "~/Dropbox/Application/emacs/docset/"))))
 ((eq system-type 'windows-nt)
  (progn
    (setq ex/linux nil)
    (setq ex/windows t)
    (setq ex/macos nil))))

(setq inhibit-startup-message t)

(global-unset-key (kbd "C-w"))
(global-unset-key (kbd "C-\\"))

(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(defalias 'yes-or-no-p 'y-or-n-p)

(cond
 (ex/linux
  (progn
    (setq default-frame-alist '((width . 210) (height . 51)))
    (custom-set-faces '(default ((t (:family "Source Code Pro"
                                     :foundry "apple"
                                     :slant normal
                                     :weight normal
                                     :height 120
                                     :width normal))))))))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(setq package-user-dir (concat user-emacs-directory "elpa"))
(package-initialize)

(defun ex/auto-install-package (package)
  """ Install package if it not has been installed """
  (if (not (package-installed-p package))
      (if (not (boundp 'xv-package-refreshed))
          (progn
            (setq xv-package-refreshed t)
            (package-refresh-contents)
            (package-install package))
        (package-install package))))

(ex/auto-install-package 'use-package)
(require 'use-package)

(use-package recentf
  :defer nil
  :ensure t
  :config
  (progn
    (recentf-mode t)
    (setq recentf-max-menu-items 15)
    (setq recentf-max-saved-items 500)))

(use-package org
  :defer nil
  :ensure t
  :config
  (progn
    (defun ex/insert-created-property (&rest args)
      "insert CREATED property when add to todo entry"
      (org-set-property "CREATED" (format-time-string "[%Y-%m-%d %a %H:%M]")))
    (defun ex/get-org-agenda-file (filename)
      """get the fullpath of the agenda-file"""
      (concat ex/org-agenda-dir filename))
    ;;(advice-add 'org-insert-todo-heading :after #'ex/insert-created-property)
    (setq org-log-done 'time)
    (setq org-src-fontify-natively t)
    (setq org-src-ask-before-returning-to-edit-buffer nil)
    (setq org-agenda-sorting-strategy '(todo-state-up priority-down time-up))
    (setq ex/org-agenda-note-file (ex/get-org-agenda-file "note.org"))
    (setq ex/org-agenda-life-file (ex/get-org-agenda-file "life.org"))
    (setq ex/org-agenda-wise-file (ex/get-org-agenda-file "wise.org"))
    (setq ex/org-agenda-work-file (ex/get-org-agenda-file "work.org"))
    (setq ex/org-agenda-tech-file (ex/get-org-agenda-file "tech.org"))
    (setq ex/org-agenda-proj-file (ex/get-org-agenda-file "proj.org"))
    (setq org-default-notes-file ex/org-agenda-note-file)
    (setq org-agenda-files (list ex/org-agenda-note-file
                                 ex/org-agenda-life-file
                                 ex/org-agenda-wise-file
                                 ex/org-agenda-work-file
                                 ex/org-agenda-tech-file
                                 ex/org-agenda-proj-file))
    (setq org-capture-templates
          '(("l" "life - IBOX" entry (file+headline ex/org-agenda-life-file "life")
             "** IBOX [#B] %? \n   CREATED:  %U")
            ("w" "wise - IBOX" entry (file+headline ex/org-agenda-wise-file "wise")
             "** IBOX [#B] %? \n   CREATED:  %U")
            ("t" "tech - IBOX" entry (file+headline ex/org-agenda-tech-file "tech")
             "** IBOX [#B] %? \n   CREATED:  %U")
            ("s" "sticky note - NOTE" entry (file+headline ex/org-agenda-note-file "note")
             "** NOTE [#B] %? \n   CREATED:  %U")
            ("c" "cccc - IBOX" entry (file+headline ex/org-agenda-work-file "cc")
             "** IBOX [#B] %? \n   CREATED:  %U")
            ("d" "djan - IBOX" entry (file+headline ex/org-agenda-work-file "django")
             "** IBOX [#B] %? \n   CREATED:  %U")))
    (setq org-todo-keywords
          '((sequence "DALY" "PROJ(p)" "WAIT(w)" "NEXT(n)" "NOTE(s)" "IBOX(i)" "MAYE(m)" "|" "CANC(c)" "DONE(d)")))
    (setq org-todo-keyword-faces '(("IBOX" . (:weight bold :foreground "#00008b" :background "#005f87"
                                              :box (:line-width 1 :color nil :style none)))
                                   ("NEXT" . (:weight bold :foreground "#008700" :background "#d7ff5f"
                                              :box (:line-width 1 :color nil :style none)))
                                   ("WAIT" . (:weight bold :foreground "#a40000" :background "#ffafaf"
                                              :box (:line-width 1 :color nil :style none)))
                                   ("MAYE" . (:weight bold :foreground "#a72f7b" :background "#404040"
                                              :box (:line-width 1 :color nil :style none)))
                                   ("PROJ" . (:weight bold :foreground "#d75f00" :background "#ffd787"
                                              :box (:line-width 1 :color nil :style none)))
                                   ("DONE" . (:weight bold :foreground "#a8a8a8" :background "#4e4e4e" :strike-through t
                                              :box (:line-width 1 :color nil :style none)))
                                   ("CANC" . (:weight bold :foreground "#a8a8a8" :background "#4e4e4e" :strike-through t
                                              :box (:line-width 1 :color nil :style none)))))
    (bind-key "C-c C-h" 'org-src-fontify-buffer org-mode-map)
    (bind-key "C-c a" 'org-agenda global-map)
    (bind-key "C-c c" 'org-capture global-map)
    (bind-key "C-c l" 'org-store-link global-map)))

(use-package term
  :defer t
  :ensure t
  :config
  (progn
    (defadvice term-handle-exit
        (after term-kill-buffer-on-exit activate)
      (kill-buffer))
    (bind-key "M-x" 'nil term-raw-map)
    (bind-key "M-h" 'nil term-raw-map)
    (bind-key "C-w" 'nil term-raw-map)
    (bind-key "C-x" 'nil term-raw-map)))

(use-package ibuffer
  :defer t
  :ensure t
  :init
)

(use-package window
  :defer t
  :ensure nil
  :init
  (progn
    (bind-key "C-w C-n" 'next-buffer global-map)
    (bind-key "C-w C-p" 'previous-buffer global-map)
    (bind-key "C-w x" 'delete-window global-map)))

(use-package windmove
  :defer t
  :ensure t
  :init
  (progn
    (bind-key "C-w C-h" 'windmove-left global-map)
    (bind-key "C-w C-j" 'windmove-down global-map)
    (bind-key "C-w C-k" 'windmove-up global-map)
    (bind-key "C-w C-l" 'windmove-right global-map)))

(use-package files
  :defer t
  :ensure nil
  :init
  (progn
    (setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))
    (bind-key "C-w C-r" 'toggle-read-only global-map)))

(use-package autorevert
  :defer nil
  :ensure t
  :config
  (global-auto-revert-mode 1))

(use-package hl-line
  :defer nil
  :ensure t
  :config
  (global-hl-line-mode -1))

(use-package paren
  :defer nil
  :ensure t
  :config
  (progn
    (show-paren-mode t)
    (setq show-paren-style 'expression)))

(use-package auto-fill-mode
  :defer t
  :ensure nil
  :init
  (progn
    (add-hook 'text-mode-hook 'turn-on-auto-fill)
    (add-hook 'org-mode-hook 'turn-on-auto-fill)))

(use-package simple
  :defer nil
  :ensure nil
  :config
  (progn
    (bind-key "C-h" 'backward-delete-char global-map)
    (bind-key "M-h" 'backward-kill-word global-map)))

(use-package menu-bar
  :defer nil
  :ensure nil
  :config
  (progn
    (menu-bar-mode -1)
    (bind-key "C-w k" 'kill-this-buffer global-map)))

(use-package scroll-bar
  :defer nil
  :ensure nil
  :config
  (scroll-bar-mode -1))

(use-package tool-bar
  :defer nil
  :ensure nil
  :config
  (tool-bar-mode -1))

(use-package linum
  :defer nil
  :ensure nil
  :config
  (global-linum-mode 1))

(use-package crosshairs
  :defer t
  :ensure t)

(use-package exec-path-from-shell
  :defer nil
  :ensure t
  :config
  (exec-path-from-shell-initialize))

(require 'helm)
(require 'helm-config)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
(bind-key "C-x C-r" 'helm-recentf)

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t)

(helm-mode 1)

  ;; (use-package helm
  ;;   :defer t
  ;;   :ensure t
  ;;   :init
  ;;   (progn
  ;;     (bind-key "M-x" 'helm-M-x global-map)
  ;;     (bind-key "C-w C-o" 'helm-occur global-map)
  ;;     (bind-key "C-x b" 'helm-buffers-list global-map)
  ;;     (bind-key "C-x C-f" 'helm-find-files global-map)
  ;;     (bind-key "C-x C-r" 'helm-recentf))
  ;;   :config
  ;;   (require 'helm-config))

;; todo: I tried add helm-mode-hook to turn on, not work
(use-package projectile
  :defer nil
  :ensure t
  :init
  (progn
    (projectile-global-mode t)
    (setq projectile-enable-caching t)
    (setq projectile-completion-system 'helm)))

(use-package helm-projectile
  :defer nil
  :ensure t
  :requires (helm projectile)
  :config
  (helm-projectile-on))

(if ex/linux
    (use-package helm-dash
      :defer t
      :ensure t
      :requires (helm)
      :init
      (setq helm-dash-docsets-path ex/dash-docset-dir)))

(use-package ggtags
  :defer t
  :ensure t
  :init
  (add-hook 'c-mode-common-hook
            '(lambda ()
              (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
                (ggtags-mode t)))))

(use-package helm-gtags
  :defer t
  :ensure t
  :requires (helm ggtags)
  :init
  (progn
    (add-hook 'dired-mode-hook 'helm-gtags-mode)
    (add-hook 'eshell-mode-hook 'helm-gtags-mode)
    (add-hook 'c-mode-hook 'helm-gtags-mode)
    (add-hook 'c++-mode-hook 'helm-gtags-mode)
    (add-hook 'asm-mode-hook 'helm-gtags-mode))
  :config
  (progn
    (setq helm-gtags-ignore-case t)
    (setq helm-gtags-auto-update t)
    (setq helm-gtags-use-input-at-cursor t)
    (setq helm-gtags-pulse-at-cursor t)
    (setq helm-gtags-suggested-key-mapping t)    
    (setq helm-gtags-prefix-key "\C-cg")
    (bind-key "M-." 'helm-gtags-dwim helm-gtags-mode-map)
    (bind-key "M-," 'helm-gtags-pop-stack helm-gtags-mode-map)))

(use-package function-args
  :defer t
  :ensure t
  :init
  (add-hook 'prog-mode-hook '(lambda () (fa-config-default))))

;; (use-package color-theme
;;   :defer t
;;   :ensure t)

(use-package moe-theme
  :defer nil
  :ensure t
  :config
  (moe-dark))  ;; (moe-light)

(use-package smart-mode-line
  :defer nil
  :ensure t
  :config
  (progn
    (setq sml/no-confirm-load-theme t)
    (sml/setup)
    (sml/apply-theme 'automatic)))

(use-package guide-key
  :defer nil
  :ensure t
  :config
  (progn
    (guide-key-mode t)
    (setq guide-key/guide-key-sequence t)))

(use-package company
  :defer t
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :config
  (progn
    (setq company-minimum-prefix-length 1)
    (setq company-idle-delay .3)))

(use-package perspective
  :defer nil
  :ensure t
  :config
  (progn
    (setq persp-initial-frame-name "src")
    (setq persp-show-modestring t)
    (persp-mode t)
    (bind-key "C-w C-f" 'persp-next global-map)
    (bind-key "C-w C-b" 'persp-prev global-map)))

(use-package ace-jump-mode
  :defer t
  :ensure t
  :init
  (bind-key "S-SPC" 'ace-jump-char-mode global-map))

(use-package undo-tree
  :defer nil
  :ensure t
  :config
  (global-undo-tree-mode t))

(use-package expand-region
  :defer t
  :ensure t
  :init
  (bind-key "C-=" 'er/expand-region global-map))

(use-package restclient
  :defer t
  :ensure t)

(use-package elisp-slime-nav
  :defer t
  :ensure t
  :init
  (dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
    (add-hook hook 'elisp-slime-nav-mode)))

(use-package yasnippet
  :defer nil
  :ensure t
  :config
  (progn
    (yas-global-mode t)
    (add-hook 'term-mode-hook
              (lambda () (yas-minor-mode -1)))))

(use-package magit
  :defer t
  :ensure t)

(use-package dired+
  :defer nil
  :ensure t)

(defun ex/toggle-buffer (buffer-name-to-toggle)
  "if not in that buffer, goto that buffer(or create one), 
if is on that buffer, delete-window"
  (get-buffer-create buffer-name-to-toggle)
  (if (string= (buffer-name) buffer-name-to-toggle)
      (delete-window)
    (switch-to-buffer-other-window buffer-name-to-toggle)))

(defun ex/toggle-term-buffer-with-command (command)
  "Create or visit a terminal buffer with command"
  (interactive)
  (let ((command-buffer-name (concat "*" "ansi-term-" command "*"))
        (command-buffer-name-to-create (concat "ansi-term-" command)))
    (if (not (get-buffer command-buffer-name))
        (progn
          (split-window-sensibly (selected-window))
          (other-window 1)
          (ansi-term command command-buffer-name-to-create))
      (ex/toggle-buffer command-buffer-name))))

;; todo: ignore the comment sign?
(defun ex/move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key [remap move-beginning-of-line] 'ex/move-beginning-of-line)
(bind-key "C-w z" '(lambda () (interactive) (ex/toggle-term-buffer-with-command "zsh")) global-map)
(bind-key "C-w f" '(lambda () (interactive) (ex/toggle-term-buffer-with-command "fish")) global-map)
(bind-key "C-w p" '(lambda () (interactive) (ex/toggle-term-buffer-with-command "ipython")) global-map)
(bind-key "C-w s" '(lambda () (interactive) (ex/toggle-buffer "*scratch*")) global-map)

(global-set-key (kbd "C-M-m") 'mc/mark-next-like-this)

(defvar ex/active-region-mode-map
  (let ((map (make-sparse-keymap)))
    map))

(define-minor-mode ex/active-region-mode
  "Active Region minor mode."
  :init-value nil
  :lighter " Region"
  :keymap ex/active-region-mode-map
  :group 'ex/active-region)

(defun ex/active-region-on ()
  (ex/active-region-mode 1))

(defun ex/active-region-off ()
  (ex/active-region-mode -1))

(add-hook 'activate-mark-hook 'ex/active-region-on)
(add-hook 'deactivate-mark-hook 'ex/active-region-off)

(bind-key "C-w" 'kill-region ex/active-region-mode-map)

(require 'go-mode)
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook '(lambda ()
  (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))
(add-hook 'go-mode-hook '(lambda ()
  (local-set-key (kbd "C-x f") 'helm-projectile-grep)))
(add-hook 'go-mode-hook '(lambda () 
  (local-set-key (kbd "C-c C-j") 'godef-jump-other-window)))
(global-set-key (kbd "C-x C-x") 'helm-imenu)

(add-hook 'go-mode-hook 'company-mode)
(add-hook 'before-save-hook 'gofmt-before-save)
(add-hook 'go-mode-hook (lambda ()
  (set (make-local-variable 'company-backends) '(company-go))
  (company-mode)))

(setq jedi:server-args
      '("--virtual-env" "/home/liwei/Envs/bolo"
        "--sys-path" "/home/liwei/bolo-server/core/src"))

 ;; don't use default keybindings from jedi.el; keep C-. free
 (setq jedi:setup-keys nil)
 (setq jedi:tooltip-method nil)
 (autoload 'jedi:setup "jedi" nil t)
 (add-hook 'python-mode-hook 'jedi:setup)
 (add-hook 'python-mode-hook 'jedi:ac-setup)
(defvar jedi:goto-stack '())
(defun jedi:jump-to-definition ()
  (interactive)
  (add-to-list 'jedi:goto-stack
               (list (buffer-name) (point)))
  (jedi:goto-definition))
(defun jedi:jump-back ()
  (interactive)
  (let ((p (pop jedi:goto-stack)))
    (if p (progn
            (switch-to-buffer (nth 0 p))
            (goto-char (nth 1 p))))))

;; redefine jedi's C-. (jedi:goto-definition)
;; to remember position, and set C-, to jump back
(add-hook 'python-mode-hook
          '(lambda ()
             (local-set-key (kbd "C-.") 'jedi:jump-to-definition)
             (local-set-key (kbd "C-,") 'jedi:jump-back)
             (local-set-key (kbd "C-c d") 'jedi:show-doc)
             (local-set-key (kbd "C-<tab>") 'jedi:complete)))

(eval-after-load "python"
  '(define-key python-mode-map "\C-x \C-x" 'jedi-direx:pop-to-buffer))
(add-hook 'jedi-mode-hook 'jedi-direx:setup)
