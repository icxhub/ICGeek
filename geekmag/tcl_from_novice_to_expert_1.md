# 语言选择之路 & Tcl 在工作中的占比

![City](../res/img/city.jpg)

<!--

Music： she 诺丁山 插曲

-->

第一讲，我们讲故事顺便讲知识：故事是我学习语言的历程，知识是大家选择语言的参考。

- 我学习语言很大程度上是根据需求去的，现在网络这么发达，完全可以根据兴趣去学。
- 语言的掌握可以在一开始就好好深入，我地初期学习都是只会皮毛。
- 做为 EE 的毕业生，除了语言还有更多语言之外的思想才是重要的。

我自称是一个做 IC CAD 的，但我不是科班 CS，所以我需要补充更多的软件知识（这段话好像很熟悉，类似的文字在很多文章里都有出现）。从学生时代说起，希望给有需要的朋友一点借鉴。

## 大学时代用的语言

- 关键词：考试
- 编程语言：C++

在学校里，EE 专业学习的编程语言，我们只有C++，很感谢老师，知道了很多面向对象的概念，用 Dev-C++ 是我用的第一个 IDE，很好用的说，现在还偶尔会用。基础知识很重要，我觉得当时我地很多程序的思想都是来自于C++，而也会我后面学习其他语言铺了很厚的基础。

对于初学者推荐第一个去学习的编程语言，这个我没有好的推荐，唯一的建议就是，如果你正在学习一门编程语言做为你的编程入门，那么把它学透。

## 研究生时代用的语言

- 关键词：网站，项目
- 编程语言：Tcl，Perl，C#

在研究生时代，参与了我们学院的网站建设，那个时候在院系办公室专门有一个放主机的机房，学院网站，以及后面的一些应用性网络服务（选课，FTP等）都是架设在这里的。这个时候我用的语言是 C# 做为网站后台语言。

跟了导师，开始做项目，带我的学长说要学 Tcl 和 Perl，这两门语言进入到我的使用中。这两门语言还是比较好学的，Tcl 的资料少一点，当时主要靠 EDA 工具自带的手册学习，Perl 有很多额外的资料可以看。入门也很快，但只是入门而已，应对工作中的变化还是要靠搜索引擎，尤其是 Perl。

在逐渐的使用中，我去改进流程，也写一些通用脚本做自动化内容匹配，有幸项目组和业内公司合作做项目，看到了别人是怎么做流程的，开始自己改实验室的流程。

研究生时代还用了 Shell，这个是上服务器必学的，现在的学生应该比我们那个时候资源丰富很多，有微信有公众号。

## 数字后端工作

- 关键词：加班，学习
- 编程语言：Tcl，Perl，VimL，Autohotkey，Javascript，Html，Php

后端在很多人眼里是一个体力活，我找到的第一份工作就是做“体力活”。一开始做比较小的设计，有时间自己去研究公司的流程，怎么学习公司的流程，看，问，改！

每一套流程都是很多经验的积累，撇开架构不谈，每一个 Script 都是有目的，有作用的。目的就是要让设计收敛更快，更好。

团队的氛围也很好，经常有分享，同事的分享也很慷慨。这个阶段用的语言主力是 Tcl，其次还有Perl，VimL（Vim Script），autohotkey，javascript，html，php。

除了做 Tapeout，用编程语言做的工作比如信息可视化，windows 操作自动化，编写 Vim 脚本等。

## 专职 CAD

- 关键字：UX
- 编程语言：C/C++，Tcl，Perl，Python，Php，JavaScript

在经过好几年的后端工作后，我开始尝试专门做 CAD，一开始的主力语言是 Tcl 和 Perl，然后 Python 很火，我也开始用 Python，跟上主流。这个阶段我更多的是对软件基础知识的补充，开头说了我补习软件基础知识，一直有补，自学一些课程，写一些博客（输入同时也输出）。做了 CAD 以后，写程序越发规范，不是原来那种一个个功能脚本，考虑的问题更多，比如用户会怎么操作，错了怎么办，方法流程是不是足够直接，如果要 support 一个问题我要花多久解决？

这个阶段更多的是做为一个应用的构建者，关注了很多库，很多开源的内容，用现有的材料搭建一个方便的应用。

做为 CAD 还要为工程师构建方便的脚本，我愿意叫这个工作 Develop for Developer，每个工程师都是经验丰富的 Developer，IC Designer，工程师的用户体验是仅次于功能的一个指标。

由于很多技术库 Parser 需要用到 C/C++ 的库，这个凭借大学的基础也会去做一点，兴趣而已。

## Tcl 在工作中的比重

Tcl 在工作中的比重是很重的，基本可以达到 30-50%，涉及到 EDA 工具接口的都要用 Tcl；把不同程序粘合起来，用 Tcl 和Shell 都可以，但是我倾向用 Tcl，Tcl 可以在EDA 工具里直接执行。

Tcl 在数字设计中占了很大的比重，用它做胶水语言也是不错的。Tk 可以用于 GUI 开发，结合 Tcl 对构建自己的开发使用环境很有帮助。接下来的极刊 Tcl 专题中我会根据下面这本书来讲，更多的谈我的使用体会和实践：

- TCL and the TK Toolkit
- https://www.goodreads.com/book/show/814182.TCL_and_the_TK_Toolkit

专题最后交付的是一个开发使用环境，以及很多模板，Demo，关键是如何高效利用 Tcl 辅助你的数字 IC 设计工作。

## 加入 IC 极客群

本群由IC 行业的几位工程师发起，以公益，开源，分享为宗旨，致力于推广 IC 极客文化，组织大家深入交流IC 设计领域知识，经验及方法学，打造 IC 设计圈的思想国。

群也欢迎群友或 IC 极客玩家随机发起不固定主题的讨论。欢迎联系文末的微信号小主入群参与分享交流。
![入群](../res/img/group_invitation.png)

## 支持 （Donate）

![Donate](../res/img/support_icgeek.jpg)