---
title: Git基本操作
tags:
  - git
id: 840
categories:
  - 技术分享
date: 2017-11-07 22:38:50
---

#### 版本移动

回退到上个版本

> git reset --hard HEAD^

前进到之后版本（可以找到commit id）

> git reset --hard [commit id ]

前进到之后版本（找不到commit id）

> git reflog
>   git reset --hard [commit id ]

<!-- more -->

#### 撤销更改

未保存至暂存区或恢复到暂存区时的状态

> git checkout -- [file]

已保存至暂存区

> git reset HEAD [file] (取消暂存区存储)
>   git checkout [file]

#### 删除文件

从版本库中删除文件

> git rm [file]
>   git commit -m "remove file"

找回文件

> git checkout -- [file]

#### 分支操作

创建分支

> git checkout -b [branch name]
>   或
>   git branch [branch name]
>   git checkout [branch name]

查看分支

> git branch

切换分支

> git checkout [branch name]

合并分支

> git merge [branch name]

删除分支

> git branch -d [branch name]