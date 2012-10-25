;; -*- Emacs-Lisp -*-

(require 'auto-complete)
(require 'yasnippet)
(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt
                              yas/ido-prompt
                              yas/completing-prompt))


;; 自动补全的配置
(add-to-list 'ac-dictionary-directories "~/emacs/auto-complete/ac-dict")
(global-auto-complete-mode t)
(setq-default ac-sources '(ac-source-words-in-same-mode-buffers))
(add-hook 'emacs-lisp-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-symbols)))
(add-hook 'auto-complete-mode-hook (lambda () (add-to-list 'ac-sources 'ac-source-filename)))

(setq company-backends '((company-pycomplete)))
;; The ac-source can be enabled solely using
(setq ac-sources '(ac-source-pycomplete))
;; or before the other sources using
(add-to-list 'ac-sources 'ac-source-pycomplete)

(setq ac-auto-start 2)
(setq ac-dwim t)

(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
		       (if (not (minibufferp (current-buffer)))
			   (auto-complete-mode 1))))
(real-global-auto-complete-mode t)

(define-key ac-completing-map "\M-n" 'ac-next)
(define-key ac-completing-map "\M-p" 'ac-previous)

(setq yas/root-directory "~/emacs/snippets")
(yas/load-directory yas/root-directory)
(yas/global-mode 1)

(defun ac-yasnippet-candidate ()
  (let ((table (yas/get-snippet-tables major-mode)))
    (if table
      (let (candidates (list))
            (mapcar (lambda (mode)
              (maphash (lambda (key value)
                (push key candidates))
              (yas/snippet-table-hash mode)))
            table)
        (all-completions ac-prefix candidates)))))

(defface ac-yasnippet-candidate-face
  '((t (:background "sandybrown" :foreground "black")))
  "Face for yasnippet candidate.")

(defface ac-yasnippet-selection-face
  '((t (:background "coral3" :foreground "white")))
  "Face for the yasnippet selected candidate.")

(defvar ac-source-yasnippet
  '((candidates . ac-yasnippet-candidate)
    (action . yas/expand)
    (limit . 3)
    (candidate-face . ac-yasnippet-candidate-face)
    (selection-face . ac-yasnippet-selection-face))
  "Source for Yasnippet.")

(provide 'yasnippet-settings)
