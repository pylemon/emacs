===================
 我的emacs配置文件
===================

安装步骤
========

首先 clone 本项目到 本地 home 目录::

    ~ $ git clone git://github.com/pylemon/emacs.git

创建 `.emacs` 文件::

    ;;;;;;;;递归的将~/emacs 及其下的所有目录添加到 load-path中
    ;;;;;;;; 会自动剔除RCS ,CVS等包含一个.nosearch文件的目录

    (let* ((dir (expand-file-name "~/emacs/"))
          (default-directory dir))
    (when (file-directory-p dir)
    (add-to-list 'load-path dir)
    (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
    (normal-top-level-add-subdirs-to-load-path))))
    (mapc 'load (directory-files "~/emacs/my-lisps/" t "\\.el$"))


目录说明
========

所有的个人配置存放在my-lisps目录, 所有下载的插件存放在lisps目录。(还不确定缺啥，遇到了再加吧。)

本emacs 配置文件依赖以下 ubuntu & pip 包。::

    ~ $ sudo apt-get install python-mode python-pip
    ~ $ sudo pip install pylint



