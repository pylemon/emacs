;; ibus mode settings
;;================================================================================

(require 'ibus)
;; Turn on ibus-mode automatically after loading .emacs
(add-hook 'after-init-hook 'ibus-mode-on)
;; Use C-SPC for Set Mark command
(ibus-define-common-key ?\C-\s nil)
;; Use C-/ for Undo command
(ibus-define-common-key ?\C-/ nil)
;; Change cursor color depending on IBus status
;(setq ibus-cursor-color '("red" "blue" "limegreen"))
;; Use s-SPC to toggle input status
(ibus-define-common-key ?\S-\s nil)
