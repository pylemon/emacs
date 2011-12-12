;; 功能:
;; python开发相关配置
;;
;; 修改时间:
;; 2011年12月12日


;; load python-mode
(load "python-mode")


;; ropemacs settings
;;======================================================================

(require 'pymacs)
(pymacs-load "ropemacs" "rope-")

(defun ropemacs-settings ()
  "Settings for `ropemacs'."
  (setq ropemacs-enable-autoimport t)

  (defun ropemacs-settings-4-emaci ()
    "`ropemacs' settings for `emaci'."
    (emaci-add-key-definition
     "." 'rope-goto-definition
     '(memq major-mode dev-modes)))

  (eval-after-load "emaci"
    `(ropemacs-settings-4-emaci)))


(eval-after-load "python"
  `(ropemacs-settings))

;; pycomplete settings
;;======================================================================

(require 'pycomplete)

(defun pycomplete-settings ()
  "Settings for `pycomplete'.")

(eval-after-load "pycomplete"
  `(pycomplete-settings))


; pydb settings
;;======================================================================
(require 'pdb-settings)
(require 'pydb)
(require 'ipython)
