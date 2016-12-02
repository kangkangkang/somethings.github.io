---
layout:     post
title:      "博客落成有感"
subtitle:   "这不是教程，我也还没能力去写教程... ...只是让大家少走弯路。"
header-img: "jekyll-blog.webp"
date:       2016-10-07
author:     "Eldath"
tags:
    - Tech
---

# 博客落成有感

在和[Jekyll](http://jekyllcn.com/)和[huxblog-boilerplate](https://github.com/Huxpro/huxblog-boilerplate)苦苦纠缠了两天半之后... ...我的博客 **终！于！落！成！** 了！喜大普奔啊！
咳咳... ...所以我稍稍谈谈用 ~~该死的~~ Jekyll在gthub pages建博客时的注意事项... ...都是经过痛苦调试换来的经验呀。

### 一些小提醒

1. 强烈先在本地配置个``Jekyll``的环境，具体可以参考[这个网站](http://jekyll-windows.juthilo.com/)，不然每次``push``之后再调试会非常麻烦。
2. 必须使用``bundle``运行环境，不然会报错。
3. 布吉岛为啥，我这运行的时候加``--watch``似乎并不能实现修改后自动重新生成站点的功能... ...所以如果你的情况跟我一样，我还是建议你写个bat，然后这个bat``cd /d``到网站目录，删除``_site``文件夹再用``bundle``执行``jeskyll``指令，再弄个快捷方式搁桌面，设置一下快捷键，用快捷键来控制它。这样效率会高不少。
4. Girhub Pages目录和本地调试目录最好是同一个，这样调试方便。
5. 善用浏览器的开发者模式... ...（捂脸）

### 关于``_config.yml``的配置

特别重要的一点是，很多博客都喜欢在这个配置文件里写个``baseurl``，然后旁边在好心地写个``Example: /blog``但在我决定不动这里，打开网站一看之后，我滴妈呀，咋变白底蓝字了嘞？！？！弄了半天，突然在另一个主题的文档上看见如果在girhub pages上建站，这个啥啥``baseurl``必须留空，不然``CSS``就没法工作... ...诶，弄完果然正常了，害得我差点换主题。所以，这个``baseurl``**万！万！不！能** 写东西！必须留空！就连``/``之类的都不行，必须像下面这样：

    Baseurl: ""

> 所以LessOrMore主题真是挺好的呢。

### 关于有些支持多说的主题的设置

有些支持多说评论的主题（比如我这个），喜欢在``_config. yml``下面放个``short-name:``我当时以为是填用户名，结果一渲染，诶，咋成了超链接了呢？后来我开发者模式一看，多说组件没有加载好... ...于是机智的我赶紧看了看多说官网，突然发现原来这个``short-name``是指多说的空间名，于是赶紧开个空间，问题解决。

> 找了我好久... ...多说的官网咋连个搜索框都没呢。

### 关于``CSS``无法加载的问题

有次我打开主页，进到开发者模式，突然发现浏览器报了一条错误，说这是 ``https://`` 网站，不接受 ``http://`` 的``CSS``返回，于是我本着不会就Bing（别问我微软给了多少钱）的精神，果真找到了提供``https://`` ``CSS``的[这个网站](http://www.staticfile.org/)。于是我就把全站的``CSS``连接都用这个网站提供的安全链接替换了一遍，重新渲染果然没报错，问题解决。

> 所以``https``大法好！

### 关于网站加速

    Jekyll是遵守Liquid语法的，文档请见[这里](http://ju.outofmemory.cn/entry/149459)。

由于我这个主题本来图就比较多，再加上Github Pages国外服务器那让人落泪的访问速度，必须使用国内CDN加速才行。

> 该死的七牛云存储，实名就算了，还要账户余额和备案... ...

所以，经过我的选择和比较，我还是选择使用了[七牛云存储的对象存储服务](http://www.qiniu.com/)用于站点的图片CDN加速 *（全站就算了，没备案呐）*。关于如何弄到七牛的免费对象存储服务我就不在这说了，这已经超出了本文的范畴。

就是有一点要注意的：由于浏览器处于安全考虑，不接受从 ``http`` 协议返回的图片渲染到 ``https`` 网页中，因此需使用 **``https`` 协议的加速链接 ** ！！！

所以，我简单介绍一下如何在类似[huxblog-boilerplate](https://github.com/Huxpro/huxblog-boilerplate)这种 **高大上** 的主题中使用七牛CDN进行加速：

首先，通过官方文档我们可以知道，在这个``_layouts``文件夹中存放的就是博客主题的模版文件，我们可以再博客中使用``layout: page/post/...``来指定使用哪个模版。而我这个主题还有一个``header-img:``的参数用来指定封面图，因此，我们可以猜出来这玩意就是在``_layouts``里面处理的！
知道了目标以后，就要着手分析文件了。首先打开``_layouts``文件夹，我这个主题不算复杂，它提供了四种模版：

![目录结构](https://oh8y59tfn.qnssl.com/in-post/something-about-my-new-blog/2016-10-07_11-17-15.webp)

我们逐个打开看看，可以发现在``page.html``和``post.html``里，它提供了两段 *基本* 相同的处理语句：

```
background-image: url('{{ site.baseurl }}/{% if page.header-img %}{{ page.header-img }}{% else %}{{ site.header-img }}{% endif %}')
```

再次通过翻阅[官方文档](http://jekyllcn.com/docs/index/)，我们可以知道在所有``site.{CONFIG}``表示的设置项都是在``_config.yml``中给出的设置项。

    听不懂？
    意思就是说比如你在``_config.yml``里面写了个``myConfig: "Eldath最可爱"``那么你在博库中的 **任意** 部分都可以通过``{{site.myConfig}}``来指代这个这个设置项，这样你只需修改``_config.yml``，就可以同时修改所有的引用处。

所以，为了以后的方便，我又在``_config.yml``里面加上了：

```
# CDN setting
image-cdn: "http://ray-eldath.is.the.most.lovely.so.does.ice1000/"
```

然后，我们就可以愉快的修改博客模版啦！由于在``image-cdn``中我们指定的路径最后已经包括了一个``/``，所以修改模版的时候只需直接改为：

```
"background-image: url('{% if page.header-img %}{{ site.image-cdn }}{{ page.header-img }}{% else %}{{ site.image-cdn }}{{ site.header-img }}{% endif %}')"
```

**注意：这里千万不能换行！！不要为了美观换行写！**

这样，再配置一下七牛提供的自动同步工具，设置``Git``每次自动调用它，再在``_config.yml``里面的``image-cdn``中指定一下CDN的地址，我们就可以在``header-img``里面直接写``header-img: "Eldath.webp"``来使用CDN加速了！

 **最后一点：该死的Firefox不支持webp渲染，逼我写了个网页禁止低版本浏览器和 ~~垃圾~~ 火狐的访问。**

## 就这些了

补遗于2016-11-27。
