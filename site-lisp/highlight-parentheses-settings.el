;; -*- Emacs-Lisp -*-

;; Time-stamp: <2010-04-10 22:38:44 Saturday by ahei>

(require 'highlight-parentheses)

(defun am-add-hooks (hooks function &optional append local)
  "Call `add-hook' on hook list HOOKS use arguments FUNCTION, APPEND, LOCAL.

HOOKS can be one list or just a hook."
  (if (listp hooks)
      (mapc
       `(lambda (hook)
          (add-hook hook ',function append local))
       hooks)
    (add-hook hooks function append local)))

;; TODO: 最后一项不知道为啥不起作用
(setq hl-paren-colors '("red" "yellow" "cyan" "magenta" "green" "red"))

(am-add-hooks
 `(find-file-hook help-mode-hook Man-mode-hook log-view-mode-hook
                  compilation-mode-hook gdb-mode-hook lisp-interaction-mode-hook
                  browse-kill-ring-mode-hook completion-list-mode-hook hs-hide-hook
                  inferior-ruby-mode-hook custom-mode-hook Info-mode-hook svn-log-edit-mode-hook
                  package-menu-mode-hook dired-mode-hook apropos-mode-hook)
 'highlight-parentheses-mode)

(provide 'highlight-parentheses-settings)
