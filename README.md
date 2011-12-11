
;;;;;;;;递归的将~/emacs 及其下的所有目录添加到 load-path中
;;;;;;;; 会自动剔除RCS ,CVS等包含一个.nosearch文件的目录

(let* ((dir (expand-file-name "~/emacs/"))
       (default-directory dir))
  (when (file-directory-p dir)
    (add-to-list 'load-path dir)
    (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
        (normal-top-level-add-subdirs-to-load-path))))

(mapc 'load (directory-files "~/emacs/my-lisps/" t "\\.el$"))

;;;----------------------automatic customize----------------------------
(custom-set-variables

  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(browse-url-netscape-program "mozilla")
 '(emacs-wiki-charset-default "gb2312")
 '(emacs-wiki-coding-default (quote gb2312)))
(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )
;; ---------------------------------------------------------------------
