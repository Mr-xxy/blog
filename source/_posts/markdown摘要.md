---
title: markdown摘要
date: 2018-05-11 17:57:40
tags:
    -markdown
categories:
    - 技术分享
---
### 概述
#### 出发点
本文主要是针对Markdown的中文文档进行整理，筛选出一些重点，查看更完整描述异步[中文文档](http://wowubuntu.com/markdown/index.html)

<!--more-->
#### 兼容HTML
Markdown 语法的目标是：成为一种适用于网络的书写语言。
HTML 是一种**发布**的格式，Markdown 是一种**书写**的格式。

不在 Markdown 涵盖范围之内的标签，都可以直接在文档里面用 HTML 撰写。不需要额外标注这是 HTML 或是 Markdown；只要直接加标签就可以了。

请注意，在 HTML 区块标签间的 Markdown 格式语法将不会被处理。比如，你在 HTML 区块内使用 Markdown 样式的*强调*会没有效果。

HTML 的区段（行内）标签如 `<span>`、`<cite>`、`<del>` 可以在 Markdown 的段落、列表或是标题里随意使用。依照个人习惯，甚至可以不用 Markdown 格式，而直接采用 HTML 标签来格式化。举例说明：如果比较喜欢 HTML 的 `<a>` 或 `<img>` 标签，可以直接使用这些标签，而不用 Markdown 提供的链接或是图像标签语法。

和处在 HTML 区块标签间不同，Markdown 语法在 HTML 区段标签间是有效的。

#### 标题
Markdown 支持两种标题的语法，类 Setext 和类 atx 形式。

类 Setext 形式是用底线的形式，利用 = （最高阶标题）和 - （第二阶标题），例如：
``` bash
This is an H1
=============

This is an H2
-------------
```
任何数量的 = 和 - 都可以有效果。(大于等于2)

类 Atx 形式则是在行首插入 1 到 6 个 # ，对应到标题 1 到 6 阶，例如：
```bash
# 这是 H1

## 这是 H2

###### 这是 H6
```

#### 区块引用 Blockquotes
Markdown 标记区块引用是使用类似 email 中用 `>` 的引用方式。如果你还熟悉在 email 信件中的引言部分，你就知道怎么在 Markdown 文件中建立一个区块引用，那会看起来像是你自己先断好行，然后在每行的最前面加上 `>`：

```bash
> This is a blockquote with two paragraphs. Lorem ipsum dolor sit amet,
> consectetuer adipiscing elit. Aliquam hendrerit mi posuere lectus.
> Vestibulum enim wisi, viverra nec, fringilla in, laoreet vitae, risus.
>
> Donec sit amet nisl. Aliquam semper ipsum sit amet velit. Suspendisse
> id sem consectetuer libero luctus adipiscing.
```

Markdown 也允许你偷懒只在整个段落的第一行最前面加上 `>` ：
```bash
> This is a blockquote with two paragraphs. Lorem ipsum dolor sit amet,
consectetuer adipiscing elit. Aliquam hendrerit mi posuere lectus.
Vestibulum enim wisi, viverra nec, fringilla in, laoreet vitae, risus.

> Donec sit amet nisl. Aliquam semper ipsum sit amet velit. Suspendisse
id sem consectetuer libero luctus adipiscing.
```
区块引用可以嵌套（例如：引用内的引用），只要根据层次加上不同数量的 `>` ：
```bash
> This is the first level of quoting.
>
> > This is nested blockquote.
>
> Back to the first level.
```
引用的区块内也可以使用其他的 Markdown 语法，包括标题、列表、代码区块等：
```bash
> ## 这是一个标题。
>
> 1.   这是第一行列表项。
> 2.   这是第二行列表项。
>
> 给出一些例子代码：
>
>     return shell_exec("echo $input | $markdown_script");
```

#### 列表
Markdown 支持有序列表和无序列表。

无序列表使用星号、加号或是减号作为列表标记：
```bash
*   Red
*   Green
*   Blue
```
等同于：
```bash
+   Red
+   Green
+   Blue
```
也等同于
```bash
-   Red
-   Green
-   Blue
```

有序列表则使用数字接着一个英文句点：
```bash
1. Amy
2. Bob
3. John
```

#### 代码区块
和程序相关的写作或是标签语言原始码通常会有已经排版好的代码区块，通常这些区块我们并不希望它以一般段落文件的方式去排版，而是照原来的样子显示，Markdown 会用 `<pre>` 和 `<code>` 标签来把代码区块包起来。

要在 Markdown 中建立代码区块很简单，只要简单地缩进 4 个空格或是 1 个制表符就可以，例如，下面的输入：

```bash
这是一个普通段落：

    这是一个代码区块。
```
Markdown 会转换成：

```bash
<p>这是一个普通段落：</p>

<pre><code>这是一个代码区块。
</code></pre>
```

#### 分隔线
你可以在一行中用三个以上的星号、减号、底线来建立一个分隔线，行内不能有其他东西。你也可以在星号或是减号中间插入空格。下面每种写法都可以建立分隔线：

```bash
* * *

***

*****

- - -

---------------------------------------
```
---

#### 链接
Markdown 支持两种形式的链接语法： **行内式**和**参考式**两种形式。

不管是哪一种，链接文字都是用 [方括号] 来标记。

要建立一个行内式的链接，只要在方块括号后面紧接着圆括号并插入网址链接即可，如果你还想要加上链接的 title 文字，只要在网址后面，用双引号把 title 文字包起来即可，例如：

```bash
This is [an example](http://example.com/ "Title") inline link.

[This link](http://example.net/) has no title attribute.
```

如果你是要链接到同样主机的资源，你可以使用相对路径：

	See my [About](/about/) page for details.

**参考式**的链接是在链接文字的括号后面再接上另一个方括号，而在第二个方括号里面要填入用以辨识链接的标记：

	This is [an example][id] reference-style link.

#### 强调
Markdown 使用星号（*）和底线（_）作为标记强调字词的符号，被 * 或 _ 包围的字词会被转成用 <em> 标签包围，用两个 * 或 _ 包起来的话，则会被转成 <strong>，例如：

```bash
*single asterisks*

_single underscores_

**double asterisks**

__double underscores__
```

#### 图片
很明显地，要在纯文字应用中设计一个「自然」的语法来插入图片是有一定难度的。

Markdown 使用一种和链接很相似的语法来标记图片，同样也允许两种样式： 行内式和参考式。

行内式的图片语法看起来像是：
	![Alt text](/path/to/img.jpg)

	![Alt text](/path/to/img.jpg "Optional title")

详细叙述如下：

* 一个惊叹号 !
* 接着一个方括号，里面放上图片的替代文字
* 接着一个普通括号，里面放上图片的网址，最后还可以用引号包住并加上 选择性的 'title' 文字。

参考式的图片语法则长得像这样：

	![Alt text][id]

####其它
#####自动链接
Markdown 支持以比较简短的自动链接形式来处理网址和电子邮件信箱，只要是用尖括号包起来， Markdown 就会自动把它转成链接。一般网址的链接文字就和链接地址一样，例如：

	<http://example.com/>

Markdown 会转为：

	<a href="http://example.com/">http://example.com/</a>

##### 反斜杠
Markdown 可以利用反斜杠来插入一些在语法中有其它意义的符号，例如：如果你想要用星号加在文字旁边的方式来做出强调效果（但不用 <em> 标签），你可以在星号的前面加上反斜杠：
```bash
\*literal asterisks\*
```
Markdown 支持以下这些符号前面加上反斜杠来帮助插入普通的符号：
```bash
\   反斜线
`   反引号
*   星号
_   底线
{}  花括号
[]  方括号
()  括弧
#   井字号
+   加号
-   减号
.   英文句点
!   惊叹号
```