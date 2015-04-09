;; @settings.org
(require 'org)
(org-babel-load-file
 (expand-file-name "settings.org"
                   user-emacs-directory))
(put 'set-goal-column 'disabled nil)
