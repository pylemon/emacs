
### .emacs ###

所有的个人配置存放在my-lisps目录, 所有下载的插件存放在lisps目录。

下面是.emacs文件

```lisp
;;;;;;;;递归的将~/emacs 及其下的所有目录添加到 load-path中
;;;;;;;; 会自动剔除RCS ,CVS等包含一个.nosearch文件的目录

(let* ((dir (expand-file-name "~/emacs/"))
       (default-directory dir))
  (when (file-directory-p dir)
    (add-to-list 'load-path dir)
    (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
        (normal-top-level-add-subdirs-to-load-path))))

(mapc 'load (directory-files "~/emacs/my-lisps/" t "\\.el$"))
```

