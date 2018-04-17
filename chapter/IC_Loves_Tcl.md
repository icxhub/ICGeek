# <span style="color:rgb(122,187,236);font-weight:800;"> IC 为何偏恋三十而立的Tcl</span>

Tcl，发音做"tickle"，是Tool Command Language的首字母缩写。

有些编程语言单独看起来并没有优势，脱离开应用场景后甚至可以说是一门即将被淘汰的语言，这一篇我们来看看Tcl 没有被淘汰、没有被取代的原因在哪里（我认为单独来看Tcl优势很弱）。

2018，Tcl 诞生已经三十个年头了，它依然做为IC 设计的主力语言存在着，为什么IC 偏偏恋上了Tcl，本文就Tcl 这门语言的特点谈谈我对这个话题的看法，用开放的心态看待Tcl。

如果你希望了解更多程序语言发明大牛对Tcl 和其他一些程序有趣的论战，可以去搜索 “Tcl War”。

* _第一部分有一个Tcl 的小测验，看看你可以得几分，了解你和Tcl 的亲密度。_
* _第二部分细数了Tcl 的优点和不足，快而立之年的Tcl 为何依然在IC 中发光发亮。_
* _第三部分我会介绍一些我的经验，我心目中好的IC Tcl 程序的特点以及展示几个实例。_

## 测一测你对Tcl 的了解

如果不知道或者回答否则不得分，回答是或者知道得1分。6-8分及以上说明你对Tcl 的了解还是不错的。

_不管你得几分，不管你是不是喜欢Tcl 这篇文章可以给你一些故事和建议。_

1. 哪家EDA 工具的Tcl Shell和Unix 上原生Tcl Shell哪个好用？
1. 你是否（**熟练使用**）下面全部的命令（1）？
    * set
    * puts
    * array
    * source
    * if/switch
    * for/foreach
2. 你是否（*熟练使用*）下面全部的命令（2）？
    * open
    * file
    * regexp
    * proc
    * clock
5. 你是否（*写过*）procedure？
3. 你是否（*用过*）Pakcage，标准库的Package或者其他人写的Package？
4. 你是否（*写过*）Package，并知道它如何被使用？
5. 你（*用过*）dict 这种数据结构吗？
7. 你（*知道*）namespace 和它的用法？
6. 你（*用过*）interp 这个命令吗？
10. 你（*知道*）Tcl 如何Trace 吗？
9. 你（*知道*）有个TK 库Bwidget？
8. 你是否（*知道*）如何获取http 数据？
9. 你是否（*用过*）wait 和send 相关的命令？
10. 你（*编写*）过C 语言功能并在tcl 中load 吗？

## Tcl 的诞生历史

<!--若作为公众号发送，注意：
可能不包含这部分或者不作为主要内容
放于后面或者仅仅作为链接.
-->

看点：**了解Tcl 语言产生的背景、历史与演变或许可以给我们一点启发，我们为什么还在用它。**

Tcl/Tk 的发明人 John Ousterhout 教授在八十年代初，是伯克利大学的教授。在其教学过程中，他发现在集成电路CAD 设计中，很多时间是花在编程建立测试环境上。并且环境一旦发生了变化，就要重新修改代码以适应。这种费力而又低效的方法，迫使 Ousterhout 教授力图寻找一种新的编程语言，它即要有好的代码可重用性，又要简单易学，这样就促成了 Tcl (Tool Command Language) 语言的产生。

Ousterhout 教授被 SUN 于 1994 年召致麾下，加入 SUNLab，领导一个小组从事将 Tcl 移植到所有其它平台的工作，如 Windows 和 Macintosh。同时为 Tcl 增加了 Safe-Tcl 安全模块, 并为浏览器的开发了 Tcl plug-in，以及支持 Java bytecode 的编译器，大字符集，新的 IO 接口，与 Java 的计算平台相连等。Tcl还有自己的浏览器。在面向对象程序设计占主导地位的今天，又开发了支持面向对象的 incr Tcl。为了鼓励各厂商开发第三方的程序，Tcl 的源代码可免费下载。所有这些努力使 Tcl 成为一个适应当代信息产业潮流的，支持多平台的，优秀的的开发语言。

Ousterhout 教授于 1998 年初，离开了 SUN，自立 Scriptics 公司，继续 Tcl/Tk 的研究和开发工作。

Tcl 最初的构想的是希望把编程按照基于组件的方法 (component approach)，即与其为单个的应用程序编写成百上千行的程序代码，不如寻找一个种方法将程序分割成一个个小的, 具备一定“完整”功能的，可重复使用的组件。这些小的组件小到可以基本满足一些独立的应用程序的需求，其它部分可由这些小的组件功能基础上生成。不同的组件有不同的功能，用于不同的目的。并可为其它的应用程序所利用。

当然, 这种语言还要有良好的扩展性, 以便用户为其增添新的功能模块。最后，需要用一种强的，灵活的“胶水”把这些组件“粘”合在一起, 使各个组件之间可互相“通信”，协同工作。程序设计有如拼图游戏一样，这种设计思想与后来的 Java 不谋而合。**终于在 1988 年的春天, 这种强大灵活的胶水 - Tcl 语言被发明出来了。**

按照Ousterhout 教授的定义，__Tcl 是一种可嵌入的命令脚本化语言 (Command Script Language)。__“可嵌入”是指把很多应用有效，无缝地集成在一起。“命令”是指每一条 Tcl 语句都可以理解成命令加参数的形式：

<!-- 源文件： <root>/res/src/tcl_structure.dia -->
![Tcl Structure， 基于 “参考2” 重画](../res/img/tcl_structure.png)

<span style="color:blue;font-weight:600;">从图中我们可以了解到有个概念很重要，你输入到Tcl的所有交互的指令或者其他接口都被认为是文本，按一定的顺序进行Parsing。</span> 这个特性在某些应用场景变得很有用，命令也是数据（某些其他语言在命令和数据方面的互通性更好）。

EDA软件对Tcl的支持现在都已经到8.6了，由于其扩展性好，调试简单，C接口友好，使用者学习成本低，这些都是商用软件的价值所在，最重要的是开源，免费。我们看到在IC设计流程中，有些文件格式是基于Tcl的，比如SDC。

<!-- Tcl 发展事件表 -->
<p style="page-break-after:always;"></p>

|Date|Event|
|------|-----|
|January 1990|Tcl announced beyond Berkeley (Winter USENIX).|
|June 1990|Expect announced (Summer USENIX).|
|January 1991|First announcement of Tk (Winter USENIX).|
|June 1993|First Tcl/Tk conference (Berkeley). [table] geometry manager (forerunner of [grid]), [incr Tcl], TclDP and Groupkit, announced there.|
|August 1997|Tcl 8.0 introduced a bytecode compiler.|
|April 1999|Tcl 8.1 introduces full Unicode support and advanced regular expressions.|
|August 1999|Tcl 8.2 introduces Tcl Extension Architecture (TEA)|
|August 2000|Tcl Core Team formed, moving Tcl to a more community-oriented development model.|
|September 2002|Ninth Tcl/Tk conference (Vancouver). Announcement of starkit packaging system. Tcl 8.4.0 released.|
|December 2007|Tcl 8.5 added new datatypes, a new extension repository, bignums, lambdas.|
|December 2012|Tcl 8.6 added built-in dynamic object system, TclOO, and stackless evaluation.|

我们现在最新使用的也是Tcl8.6，最近一次发布时Jul 27, 2016。

## 三十而立的Tcl 为何依然发光发热

<!--表达作者的主要观点，本文的第一个重点.-->

看点：*优点并不是任何场合都适用的，天天和IC、Tcl 打交道的你看看我对Tcl 有点的总结。*

* 免费

免费，尤其是对商业免费是很重要的，企业对轮子的选择，如果不想自己造，那就要规避产品的法律风险，而免费开源（某些协议）首先消除了企业的这一顾虑，开源更是给了企业更大的自主权，可以利用整合的力量。免费开源这一点对于我们个人生活工作中对工具或者学习材料的选择，就理性而言（感性除外），需要考虑风险，成本与产出；任何人的时间和关系都是成本，企业更加关注成本这类关键字。

* C 的结合紧密

Tcl 是用C 语言开发的。它现在可运行在Unix，Windows 和Macintosh 等各种平台上。与C/C++ 的精密结合，互相调用方便进行切入。高可用的商业软件使用C++ 开发的很多，而选择一种脚本语言可以做为高级语言的辅助工具也很重要。从Tcl 中访问C 语言可以在外部为程序临时打补丁；相反，从C 语言中方位Tcl 可以将输入内容传递给内部功能。你中有我，我中有你的配合虽然在最终用户处使用场景不多。IC 设计需要调试（Debug）具体设计，还要调试（Debug）工具特性，这种异常复杂多变的场景，Tcl 为其提供了类似于在线调试的能力（在线意思为实时互相通信），充分利用了编译语言的可靠性和脚本语言的灵活性。

* 开发部署周期短

脚本语言是解释性语言，不需要编译，这个是脚本语言通性，这个特性保证了支持团队的反应时间。如果工程师在设计中遇到一个问题，发给支持团队，可能是EDA 公司，可能是公司内部的CAD 部门，他们需要重新编写一些功能，对代码进行编译，测试，然后再发给到出问题的工程师手里，如果还是不能解决问题，则需要继续迭代，这个沟通过程当然有点典型和夸大的成分，非常没有效率；但如果使用脚本语言，不触及最核心的高级语言功能代码，只是对外部的东西进行处理，提供一个接口与内部进行沟通，脚本的测试和调试也要快很多。总结来说就是开发和部署的周期大大缩短，适合IC 行业，IC 行业中的核心功能算法不需要快速迭代，AE 或者CAD 工程师面对的是如何将客户的数据或者输入格式调整到工具能够识别的最佳状态，找到一个最好的输出Result。

* TK 图形界面

Tk (Tool Kit) 是基于 Tcl 的图形程序开发工具箱, 是 Tcl 的重要扩展部分。Tk 隐含许多 C/C++ 程序员需要了解的程序设计细节, 可快速地开发基于图形界面 Windows 的程序。据称, 用 Tcl/Tk 开发一个简单的 GUI 应用程序只需几个小时, 比用 C/C++ 要提高效率十倍。需要指明的是这里所说的“窗口”是指 Tcl 定义的窗口，与 X-Windows 与 MS Windows 的定义有所不同，但它可完美地运行在以上两个系统上。

TK 做为各种脚本语言基本上都支持的一种图形界面，它的Component binding 等思想到现在都是很好的方法。图形界面是和用户进行交流的一个重要工具，TK 最为一个快速的模型，可以很简陋也可以很优雅。在最后一个部分，我将会介绍几个TK 的著名程序，除了使用它们，阅读它们的源代码也会受益匪浅。

* 调试性语言

把Tcl 叫做调试性语言，是因为Tcl 做为一种粘合工具，很容易开发出一套访问核心数据的接口命令，比如EDA 工具的get_以及report_系列命令。获取信息后配合set_系列命令，快速调试环境，继而配置需要的内容。而Tcl 本身作为程序语言，虽然比不上Lisp 等语言完备，但是应用起来也不成问题，所以简单这个特性在自动化测试（Test），调试（debug）中便成了Tcl 的一个优势。

* 整合性语言

Tcl 和C 方便的接口，让它拥有了强大的整合能力。撇开C 语言，即使Tcl 做为单纯的外部Wrapper 工具（套壳工具）也是合格的，这里我指的是利用Tcl 将不同的可执行程序，或者不同语言的脚本整合到一起，Tcl 本身就是为这个而设计的，有一套处理异常的方法和完整的输入输出能力（当然这个并不是多大的优点）。我习惯给核心程序外加一层命令或者函数去判断其是否出错，（有些编译型的程序语言的错误处理当然必须先编译），对于line by line 执行的Tcl 来说，必须加一件外衣才能去catch 命令的错误。

* 入门简单，转移关注度

学习成本低对于商业软件来说价值很大，对IC 工程师尤为重要。一个复杂的语言，学习成本高，迭代周期长导致迭代成本高，不利于问题的分解，容易让工程师偏离IC 设计的主要矛盾 - 设计本身的PPA。这个特性也是Tcl 发明的最主要动力，很多工程师的Tcl 知识其实到第一个level 就够用了，我一开始的十几个个问题，能得到5-6分应该就算第一个level 了。

* 扩展性强（package 的优势）

Tcl 的Package 和其他程序语言的库都是很像的，而且Tcl 自身也提供了一套如何维护库的命令。Tcl 的库如果不涉及编译的话（比如需要访问数据库）是纯文本，可以说很简陋，当然你也可以把这个扩展用得很高大上。从简单的思想拼凑到优雅很直接，而简化一个复杂的结构是有一定难度的。

* 跨平台（Tcl 本身）

很多系统操作命令，不同平台的方式都是充分利用操作系统的资源，包括TK 这个界面程序也是一样，在保证功能一致性的情况下，无需编译便可以跨平台运行。

* 网络功能（Tcl 本身）

Tcl 通过http 包可以方便地进行网络访问，大家可能有用python 或者任何其他语言做爬虫的经验，Tcl 也是可以的，但是如果用在IC 上，用在系统的构建上，这个能力也是不可或缺的。

## IC 工程师为何要熟悉Tcl 以及其他脚本语言

<!--从JD 谈起，如何自查tcl 水平和提高Tcl 编程能力。
本文的第二个重点。
开发若干问题，由浅入深提到Tcl 的概念做为测试的级别划分。-->

看点：*一点学习Tcl 的想法，即使你厌恶编程，为了提高效率，为了绩效，为了工资，为了面试，你应该看一眼。*

前面我列出了十几个问题，涉及了Tcl 的不同方面，仅涉及对程序语言的熟悉，不涉及各种额外的编程思想。

我曾经对物理设计的职位做过词频统计，去除了一些语法词以后，Physical 当然出现最高，Tcl、Perl 的频率也排在前列。

* Tcl
* Lisp
  * Sheme
  * SKILL
* Perl
* Python
* Shell

## Tcl 家族：Tcl/Tk/Expect

<!--普及Tk 和Expect，本文的第三个重点，既然放在最后，关注度没有前两个高。-->

看点：*即使只用Tcl、Tk、Expect 也可以创造一个自己的IC 黑客帝国。*

## 好的Tcl 程序的标准

<!-- xhub 最佳实践 -->

Tcl 本身的特性，可以让很多想法在Tcl 上实现，EDA 工具原生支持是它在IC 领域的最大优势。

## Tcl 优势的几个实例鉴赏

有几个常用的TK 工具，很好用的工具，同时它的源代码也值得一看。

<!-- 几个Tk 程序的例子 -->

### tksqlite

sqlite IDE

### tkinspect

TK inspect tool

<!-- Reference in new page -->
<p style="page-break-after:always;"></p>

## 参考内容

* 《Tcl & the Tk Toolkit》
* 《Tcl/Tk : a developer’s guide》
* 《Practical Programming in Tcl and Tk》
* http://www.wikiwand.com/en/Scripting_language
* https://blog.csdn.net/larryliuqing/article/details/20902181
* http://scc.qibebt.cas.cn/docs/linux/script/TclTkall.pdf
