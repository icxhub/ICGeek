# Tcl/Tk - 在实践中由浅入深

Tcl/Tk - From Novice to Expert

![isometric-art-art-tattoos](../res/img/isometric-art-art-tattoos.jpg)

从不久的之前开始，我就陆续在微信等平台上分享，由于各方面的原因，很多计划中的事情没有去 follow up，今天想要在 IC 极刊 上做的这个 Tcl/Tk 专题其实计划良久，也曾经屡次被各种外界因素干扰中断：

- 清丰陪你读IC - 本专题讲话延续原来的思想，做一些改进，但是我们的专题还是以书为本。
- TK 实践 - 这个专题会涉及到Tk 界面编程。

上面的两个专题都是开始不久便停止了，其实我个人觉得是两个不错的 idea，如果能坚持的话。

---

在网上看到很多以基础知识或者以实践为主的 Tcl/Tk 教程，做为学习材料都是可以的，我一向提倡认准了一条路走下去，而不是在选择学习素材上大费周章，把学习的热情提早消耗完了。

我从研究生开始接触 Tcl/TK，然后工作成为后端工程师不断地强化我的脚本水平，到做 CAD 后对Tcl/Tk 有了一些不一样的认识，通过分享一些个人的想法，希望能对大家有所帮助。

打个比方：

1. 从一开始我整理脚本的方法是留在项目里，新项目开始我就要使劲去翻旧项目，copy-paste 写新的脚本；
2. 然后我开始将我的脚本集中管理，放在一个公共目录里，这个方便很多，但是还是会有同步等问题；
3. 随着工作环境的变化，我用起了版本管理，但是脚本本身还是零碎的；
4. 也随着对 Tcl 认识的加深用起了 Package 来管理；
5. 现在除了用 Package，还保留了很多实例，手册等为开发而发展出来的方法和工具。

我相信很多人在上述五个过程的某个阶段，如果大家像读故事一样，知道了我的学习过程，是不是可以直接到第四第五步，所谓站在巨人的肩膀上就是这个意思吧，当然我还称不上巨人。

上述只是一个例子，我们的目标和课程任务是一致的，通过这个课程，学习到 Tcl 的基础和非基础的知识，并构建一套有效的 Tcl 开发和使用环境，能用 Tk 进行自己 GUI 想法的实现。

先预览几个 Topic，后续很大程度会做内容和结构的微调。

---

![海报](../res/img/tcl_tk_from_novice_to_expert.png)

---

1. 我在用哪些脚本，Tcl 在日常中的比重
2. 我怎么管理我的各种 Tcl 脚本
3. 用 Tcl 处理 CSV，为什么用 CSV 为例子，有深意
4. 这个话题很重要，正则表达式
5. 如何做优雅的异常处理
6. 用自己的脚本替代 EDA 工具内置的命令
7. 讲讲 Tk - Bwidget
8. ...

## 实力讲解

每期我都会设计一段脚本，做为实力（实例）讲解。

今天是第一篇，我挑了一个我在自己 windows 上用的脚本，根据 extension 自动给文件归类，其实这个应用很多软件都有，但是为了这么一个小小的需求，尝试各种软件，而且也缺少定制性，不划算，Tcl 用用足以，当然任何脚本语言写这个应用都是小菜一碟。

程序很简单，我写了一些注释，当你使用下面 grep 命令可以获得特定的注释，再简单处理就可以得到一个文档的东西：

``` sh
$ grep  mydoc sort.tcl
# {{{ #mydoc# Define mapping between extension and path
    # #mydoc# If extension does not match, return.
    # #mydoc# If extension does match, move.
    # #mydoc# Move both file and folder
```

``` tcl
set allitem [glob -nocomplain ./datain/*] ;

# {{{ #mydoc# 定义一个数组做后缀和路径的mapping
set moveto(doc) "material/doc" ;
set moveto(docx) "material/doc" ;
set moveto(pdf) "material/doc" ;
set moveto(jpg) "material/img" ;
set moveto(png) "material/img" ;
set moveto(gif) "material/img" ;
set moveto(xcf) "material/dgn" ;
set moveto(exe) "material/exe" ;
set moveto(zip) "material/zip" ;
set moveto(7z)  "material/zip" ;
set moveto(rar) "material/zip" ;
set moveto(tar) "material/zip" ;
set moveto(gz) "material/zip" ;
set moveto(folder) "material/sub" ;
set moveto(chm) "material/doc" ;
set moveto(pptx) "material/doc" ;
set moveto(epub) "material/doc" ;
set moveto(csv) "material/doc" ;
set moveto(js) "material/dgn" ;
set moveto(sb2) "material/dgn" ;
set moveto(jfif) "material/img" ;
set moveto(msi) "material/exe" ;
set moveto(crx) "material/exe" ;
set moveto(azw3) "material/doc" ;
set moveto(xlsx) "material/doc" ;
# }}}

#set fh [open sort.cmd w]

foreach itm $allitem {
    set fileext [lindex [split [file extension $itm] .] end] ;
    # #mydoc# If extension does not match, return.
    if {![info exists moveto($fileext)]} {
        puts "No match for $fileext" ;
        continue ;
    }
    # #mydoc# If extension does match, move.
    if {![file exists $moveto($fileext)]} {
        file mkdir $moveto($fileext) ;
    }
    if {![file exists $itm]} {
        puts $itm ;
        continue ;
    }
    # #mydoc# Move both file and folder
    if {[file type $itm]!="file"} {
        exec mv $itm $moveto(folder)/
        #puts $fh [subst { mv $itm $moveto([folder])/ }];
    } else {
        catch {exec mv $itm $moveto($fileext)/}
        #puts $fh [subst { mv $itm $moveto($fileext)/ }] ;
    }
    #close $fh ;
}

# vim: ft=tcl foldmethod=marker
```

## 加入 IC 极客群

本群由IC 行业的几位工程师发起，以公益，开源，分享为宗旨，致力于推广 IC 极客文化，组织大家深入交流IC 设计领域知识，经验及方法学，打造 IC 设计圈的思想国。

群也欢迎群友或 IC 极客玩家随机发起不固定主题的讨论。欢迎联系文末的微信号小主入群参与分享交流。
![入群](../res/img/group_invitation.png)

## 支持 （Donate）

![Donate](../res/img/support_icgeek.jpg)