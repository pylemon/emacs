;; -*- Emacs-Lisp -*-

;; Time-stamp: <2010-04-10 20:11:26 Saturday by ahei>

(require 'template)

(eal-define-keys
 '(emacs-lisp-mode-map c-mode-base-map makefile-mode-map makefile-automake-mode-map
                       sh-mode-map text-mode-map)
 `(("C-c T" my-template-expand-template)
   ("C-c C-t" template-expand-template)))

(defun template-settings ()
  "settings for `template'."
  (setq template-default-directories (list (concat "~/emacs/" "/templates/")))

  (defvar last-template nil "last-template")

  (defun my-template-expand-template (template)
    "my-template-expand-template"
    (interactive
     (list
      (read-file-name
       (if last-template (format "format: " last-template) "last-template")
       (concat "~/emacs/" "templates") last-template t)))
    (template-expand-template template)
    (setq last-template template)))

(eval-after-load "template"
  `(template-settings))

(template-initialize)

(provide 'template-settings)
