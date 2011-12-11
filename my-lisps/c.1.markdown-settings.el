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
