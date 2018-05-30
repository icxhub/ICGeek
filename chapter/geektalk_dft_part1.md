# 极客说-DFT 主题讨论-Part1

**作者：群聊笔记**\
**编辑：高原**\
\
![Secret By Jun](../res/img/secret_by_jun.jpg)

**友情提示 ：**

> 1. IC 极客之家是由IC 行业的几位工程师发起，每周群内发起涉及IC 设计各领域的主题头脑风暴，群友也可随机在群内发起提问，入群请加微信号 sgsphoto
>
>  ![image](../res/img/wechat_sgsphoto.jpg)
>  
> 2. 极客专栏，极客说，极客问答文章请关注公众号icgeeks.
> 3. 极客说与极客问答整理及信息来源以群内聊天记录为准，内容无法一一确认过滤，为保护群友个人隐私，整理目前暂时采用匿名方式，未尽之处请联系群主高原(sgsphoto)，做修改更新或者删除。
> 4. 请新入群群友于群公告处阅读群规，并在接下来的讨论中积极参与。
> 5. 我们从第一篇文章就开始托管于github，https://github.com/icxhub/ICGeek 采用知识共享协议，每篇文章都有原本链的DNA唯一标识，实验数据也在里面，欢迎大家围观。文章版权所有，合作联系微信号 sgsphoto.

---

### Q1 - DFT 的工作覆盖了SOC 设计全流程，从系统设计，IP，到前后端，再到片后，跨部门的沟通协作非常重要，如何做DFT 与跨部门之间数据交互，版本管理，需求管理

1. 跨部门数据管理和版本一般不是问题。需求管理我觉得依赖文档的流程规范，和公司的开发ISO规范。当然需求有不确定性，变更或增加需求时，需要考虑时间和修改的代价。
2. 更多精彩观点请参考极客专栏文章"配置管理"和极客说文章"持续集成".

### Q2- 接上问，DFT 在跨部门协作中有哪些guideline 或checklist 需要follow，使得协作更加顺畅

1. 在mbist模式下，会带动所有func 的逻辑翻转，导致IR 分析过于悲观，给debug 带来不小的干扰！之前mbist IR 比较严重   也是因为func 在动。我们的做法是修改设计将func 和mbist彻底隔离开，mbist 下func 不翻转，解决了IR.

2. 经常跟前端沟通的是scan mode select 信号的处理，这里可以DFT 处理，也可以前端处理好；还有是关于clock 架构，一般是希望前端给clock 架构图，因为DFT 可能会做mux clock的操作，以及考虑occ insert 的位置; DFT 不合理的压缩比和scan chain order 会造成后端congestion; DFT 最有可能造成的是scan mode 下的hold violation

3. 大的design 的架构，对DFT 或者说ATPG 影响不大，换句话说，你不论什么功能的芯片，蓝牙，wifi，基带，图像处理，我ATPG 都能做，所以不太care 架构，有影响的的是时钟的架构，尤其是低功耗的design，有非常严格且多变的时钟控制，这个会很影响at speed scan.

4. 先不扯ATPG，说说mbist，稍微简单点，我做的SOC ，里面大概有1600多块memory，由于我们是在rtl阶段就引入mbist，所以，DFT 的同学要跟function 的同学去align 这些memory 的需要啥类型？单端口双端口还是寄存器based？ 跑多快时钟？size大小？要不要掉电保护？ 根据size 大小决定要不要修复功能？已经预留多少可修复地址？然后根据需求去找memory group 定制memory，然后包bist，包好后deliver 给function 的人去在rtl中实例化。另外还要function 的人和pd 的人一起review mbist 的sdc，跟function的人align在 at speed mbist下的时钟控制，push function的人去按dft的规则实现dft可控的时钟.

### Q3- TCL 及Python 编程在DFT 流程中分别有哪些应用

1. 针对阶层设计中，根据每个block的dft spec，用来批量提交dft任务。批量检查dft的结果。减少手工操作。修改网表,修复dft drc,计算最终ATPG 的覆盖率。

2. 更多精彩内容参考极客说文章"IC 为何偏恋30而立的Tcl".

### Q4- 你心目中好的DFT 策略的标准是什么？DFT设计在IC 设计的成本中占比多少？

1. DFT设计需要考虑测试时间和成本，也是约束DFT 设计的一方面

### Q5- 有一种DFT 叫logic test 人们却很少提及，有这方面经验的吗？

1. 前面有人提到 logic bist，有幸前端时间试用了synopsys的flow，没有学习的很好，一些对可靠性要求比较高的芯片会使用，像车规，医疗;
2. logic bist的优势是可以不依赖ate设备就可以进行测试，比如汽车可以在启动前做一次lbist测试确保芯片没有因为老化失效
3. logic bist目前主要在两处应用比较多 1， 汽车等对可靠性要求高的芯片 2. 高速芯片，  lbist 不像scan那样需要插链，导致timing问题。 所以高速path 通常也使用logic bist 测试

### Q6- 降低量产测试的测试时间，常用技巧有哪些

1. 量产需要考虑testcase合并与组合
2. scan方面可以用parallel的多条scan chain
3. 调整testcase的顺序，可以节省时间

### Q7- 芯片回来bring up , 就是有很多点测试不过,一般有哪些原因?前提是时序，后仿都是好的。 大家不要说是IR drop 影响的, 因为升压降压 ，fail的点都一样

1. 也碰到一个case 就是pll输出时钟的Jitter超出预期，那么在timing和后仿都ok的情况下，有些高频的逻辑测试不过！应该也算作一种情况吧！

2. 芯片bring up问题我回答几个碰到过的情况，1.测试那边timeset可能有问题，2.stil/wgl转apt pattern后建议也写tb跑一下仿真，因为转pattern有可能丢掉一些信息.
 
3. 我们还碰到过probe card把两个端口位置做反了，其中一个是mode信号谢谢您的information 。 大概3万多的pattern，费掉几十个。fail 几十个点

4. 你说的应该是debug初期的问题```是的``` 那应该都不是.我说的问题，大部分过了，少量不过
  - 这是什么pattern? stuckat transition?

  - ```stuck at```
    - 坏点是固定的pattern fail么？多个芯片的问题一样么？
    - 有没有可能是pattern version和tpo版本不一致，比如eco了没有重新出pattern? ```应该不是。pattern 是基于最后的网标生成的```
    - 晶片划的时候伤害了? 看看坏片在晶圆上的分布
    - 另外，换其他die测试都一样吗？

### Q8- MBIST 走RTL flow还是netlist flow? 各自的优缺点

1. 我觉得mbist走rtl flow 比较好，综合只需要跑一遍，优化效果好，仿真也好仿。在网表上做真想不到什么优点。
2. 但是走rtl flow 需要维护两套database 
    - 改也是改两份 到final 阶段，memory没啥变化，还可以。
    - 两套database 是哪两套
      - 有bist 的一套 ，没有的一套 版本控制有麻烦。
      - 一套是dft 输入，一套是dft 输出，前端应该只在final 版本才会拿含bist 的版本回归一下仿真吧

3. rtl 的仿真快，缺点是文件太多。插完bist 后， 要控制version再做综合。```最后做eco 也要改两套rtl```

### Q9- 你们在group memory 的时候，一般会手动干预调整吗？

1. 通常来说不调整也是可以的对吧 你遇到了需要调整的情况吗，在group memory时有什么准则需要遵循吗
2. 手工干预比较少。但是需要读入def文件，告知memory的位置。功耗  测试时间上考虑，来调整memory的group 还有routing 、area

### Q10- 企业重视DFT吗？

1. 反方

- 大多数老板认为dft和后端是一伙的吧
- 国内还得租测台，小公司从来没这部分预算
- 测了赔钱，不测挣钱，你选哪个？
- 要看design规模和复杂度，工艺，单独来讨论哪个function的value我个人觉得毫无意义
- Dft很没话语权的，以前在ibm叫fep， 连io都要负责插进去，结果后端一直催dft，不然没东西做
- 对前后端来说dft就是累赘  
- test clock 好烦
- dft属于偏门
- 矿机这种 就懒得做了。矿机做了影响性能。矿机里  多数是计算单元某一个地方坏了，不影响芯片的功能
- 小的系统0.3美金。本来就没想你能很好。比如几毛人民币的8051 otp

2. 正方

- 专职dft的路过，感觉受到了万点伤害
- 不重视dft，只能说明公司产品单一或者出货量小,量大的话 可以试试公司能撑多久不赔死
- 我仍然觉得有些不可思议，没有dft,客户拿到坏的产品，数据算错是要遭受巨大的损失的

- dft可以改名字了，不仅要t还要d
- dft是对cortex m3以上的芯片一定要的。不然退货成本更高
- 如果退货和赔偿20k就受不了了。

- 大公司可能比较重视
- 现在做IP阶段都需要DFT
- 大部分大公司是拼谁储备的IP多，IP质量越高，搭积木就越省力，响应客户需求就更快，这是趋势。所以IP阶段，Lint, CDC, Synthesize, DFT都必须得上。当然这得公司有一定规模，不然玩不起
- 大公司flow成熟，dft这种大多给cad团队包好了
- 因为产品线除了换代对dft影响大些以外，平时改版的内容对dft影响不大，复用以前flow更能保证覆盖率一致，当然前提是一开始覆盖率就有保证了，然后就基本固定
- DFT 属于前端还是后端?
    - 全局考虑就是前端，具体实现就是后端。DFT非常重要，只是目前很多中小公司意识不到。

- 我猜做成熟工艺的产品的部门的大公司比较重视
- 成熟工艺需要dft，不成熟工艺更需要dft
- 高可靠性芯片才需要dft吗？准确讲是要高良率的芯片(+1)
- 成熟工艺。。。说白了就是做量产生意的
- 高可靠性的比如军品，他的dft方案不仅仅是业界那些，里面还有很多测量结构
- 宁可降低性能也不能少了dft
- 所以做dft 和验证的是不是军工 航天的片子更受重视```在国内是的,汽车电子也非常重视```

- 现在一般DFT coverage是98%？
- scan coverage要达到98%以上
- 一般sa 95%以上, atspeed70%以上 这个跟设计很相关，国内小公司大概这个标准就过了
- 台湾公司卡覆盖率比较紧，至少98%

### Q11- 有谁现在用Mentor redundancy repair flow?

- 我司在用
- 也插播一个问题，请教下，现在大家memory repair用的多吗，一般有啥原则？比如多大的memory要做，或者需要做到啥程度? ```chip规模大的，工艺先进的良率不高的，一般都要ram repair```
- 有什么自动repair的算法？```bist 内置bira可以根据memory redundant信息和出错位置计算出是否可以repair和怎么repair, 看你用怎么样的带repair的ram，行优先列优先，repair算法相对比较固定的,一般是读写不同时钟域的，连一个快速时钟，减少 bist controller数量```

- repair需要的efuse bits一般怎么算呢？```bist engine自动算好压缩加烧fuse 这个要做了才知道，如果一开始算面积要知道的话，有公式吗？```
- 一般不会全都错，选个compile最小的都可以
- DFT 外行问个弱弱的有点外行的问题，repair 以后的chip 性能，timing 一样么，设计的时候如何考虑repair 下的scenario ```没有区别```
- 如果选了repairable memory ，repair是否不影响timing，
- 面积功耗都增加，另外时序收敛周期变长，也会增加成本
- memory repair哪个工具可以做？我们现在都是手工编rtl ```mentor tessent push button solution tessent挺好用的```
- 比如sram的基本单元是8bit，如果这8bit中只有1bit有制造缺陷，那么修复时是8bit一起用dummy替换还是只替换其中的一个bit？```看memory实现```
- 这不应该是修复逻辑实现的吗？与sram物理结构也有关系
- 替换一个column 把地址重新映射一下
- 只修一个bit
- thanks。我也觉得只修1bit比较合理。整个col太浪费

- 只修一个设计代价是不是太大了
- 比如mux8就是不管 column address
- 不同的mem库不一样   tsmc 12纳米的库只支持colum 修复   snps 的row和colum都支持

- 我们memory是模拟工程师自己设计的，不是IP，可以用mentor的工具吗```可以```
- compiler生成mentor memory library 
- 照mannual 手写 mentor memory library
- 控制接口比较复杂，地址和数据带串并转换的。```那就比较困难```
- 可以把串并转换单独做一层,做成memory  wrapper,或者把address data mux 做在这一层，直接暴露并行的bist data address
- 并行的模拟电路里面，数字看不到 ```让模拟加mux```
- 如果加mux，layout和apr都有压力```那就写sharebus interface 每次测一个 所有memory share一组 data address bus```

- 加串并转换的目的是减少地址和数据总线的线根数，减少数模接口的连线。

- repair需要用的efuse bits可以估算吗？ ```可以，根据期望repair的mem个数，mbist tool可以给出一个bit值```

### Q12- 用tessent时，有没有手写过ICL PDL```有```

- 主要在哪些情况下需要，是必须的，经常的吗？```一般主要写pdl 比如写TDR icl 一般不需要写，除非你有些custom的IP需要加到ijtag network里去```
- 一般直接dftspec里加tdr控制就足够了
- 我刚开始用tessent没多久，之前AE告诉我像pll，分频电路之类都要手写ICL，感觉有点违反我的直觉 ```写了icl就自动生成tdr 都可以，看喜欢怎么做```

- 举个简单的pdl例子，mbist里memory需要在不同的timing margin controls bits 下都通过，需要加tdr 控制，在每次mbist 测试前，写这些tdr
- pll 分屏直接 dftspec加tdr
- 这个tdr是一条独立tdr还是共用tap上的tdr呀？```这个看测试要求 可以每个memory单独的 也可以一种类型连在一起 也可以每个时钟域连在一起```
- 不是tap的tdr，ijtag tdr
- icl是啥缩写？没用过第一次听说```Instrument Connectivity Language (ICL)```

### Q13- DFT 如何跟前后端彼此友好

- 我觉得dft对后端不友好的主要问题在于时钟的规划，时钟规划不合理会带来好多timing问题```深有体会```
- 我以前经常碰到的一个问题，dual port sram，bist算法里面会有两侧同时读写统一单元的问题，bist时两侧又是统一时钟，后端需要费好大劲去推时钟避免collision。但事实是func底下设计时早都考虑了，根本不会出现这问题。改问题纯粹是mbist引入```所以clock不背锅```
- 还有scan chain的时钟规划问题，没有考虑clock skew，有时候func mode下skew已经大的吓人，还要在scan下去修

### Q14- func 和各个测试模式下sdc merge的策略

- 不建议 merge SDC (+1)
- 对工具不友好
- 有没有人就是要merge 的？出于怎样的考虑呢？
- merge好处是所有目标都能看见，一次把状态空间限定好？
- 各个corner 都跑，满足不了客户的schedule
- 大家的做法都是不merge？一般都是pr要求merge的，可以multi-mode一起修。不过merge确实会带来不少额外的问题
- scan clk可以不用balance
- 不merge的话也可以mmmc一起修啊
- scan clk确实不必要balance，不知道大家为何觉得dft对后端不友好
- 不友好的原因主要是因为不知道或者是不遵循设计原则，我希望通过讨论能够知道和理解这些原则
- 不balance对hold问题怎么解决
- 他们应该说的是，不同function clock domain在scan mode被切到同一scan clock的情况吧

- pr和后端是希望merge的 可以出不同需求的sdc signoff的可以和pr的不一样
- func和scan合并没必要吧，scan的几种模式可以合并
- dft clock不需要额外很多的effort才是合理的clock设计 看clock设计吧，capture可以和func merge，也可以dc ac capture merge
- dft时钟基本都是用function时钟 只会少 不会多 merge在一起做
- 部分一段 可能想合并
- 一般是mbist、AC lunch/capture 可以和func合并吧
- mbist和func合并就好了，scan为何还拆出一种去和func合并呢，即便合并了scan剩下的还是一种模式，为何不把scan的所有模式合并成一种？
- dc ac的capture是如何合并的？
- 在occ的输出上分别定义generate clk，master clk分别指向scan clk和对应的func clk，再设group

### Q15- 你们dft 的clock mux是放在 分频寄存器前面吗

- 为什么分频 在dft时要做mux? ```复用function分频会在分频后插occ，用dft自己得分频需要在原分频后插mux吧```
- 这么说吧，fuck本身有分频，插入dft clock的时候怎么处理
- 了解您们的做法，这个要看您们的DFT的设计方法，我们通常是OCC做在源端 即PLL。 整个SOC好多分频电路，您说的额应该是 主干clock的fenpin
- 一般时钟单元的的dff不进scan 因为分频器出来的时钟不会bypass到其他dff的D端
- 分频reg是non-scan的
- 我的理解是dft clock 通过mux共用后面的clock path，是这样吗？ ```如果mux 在分频器前，scan clock是会bypass 分频器吗？要不然scan clock 也被一起分频了？ 或者说分频都有一分频功能，scan mode 下是一分频```
- 分频输出再加mux 嘛
- 如果用很多路分频，都是有不同分频器分出来的，那咋么办？ 都在分频器后面加MUX？这样mux很多，scan clock和func clock 会很多分支路径 最后体现在sta上就是scan clock 看到的timing和function 差异巨大 没有建议，看看各位有没有好的建议，大家一起讨论
- 很多路分频是什么意思？分频器串在一起吗？ 还是很多独立的分频器
- 独立分频器 比如那种挂外设接口的那种
- 分频器后面挂了很多ff
- 其实不是很多一千以内的样子 直接放弃他们？ 在分频器后面再加个mux是不是可以解决 一路直通，一路过分频器 通过scan mode来控制
- 分频器后加mux
- 终极目标就是希望能尽可能的的复用功能的buffer tree

### Q16- 插一个问题，memory bist的时钟有几种常用产生方式，想了解下大家都是怎么处理的。1用片外时钟加mux替代func下时钟；2 直接用func时钟（通常片内pll产生）；3用其他片内时钟加mux替代原func时钟**

1. 从前我只用第一种，开心生活了很久，现在需要用第2 甚至第3，
2. 第一种是比较开心，哈哈
3. 1 2 3都用过  3用得不多.1的话外部io灌进来的时钟频率低  1的主要问题就在于时钟频率低  现在觉得3最麻烦，很可能带来很多timing问题, 3的话凭空多了很多path

### Q17- 请給大家讲下podem 算法 d算法 和 fan 算法的区别

有时间写个简单ppt介绍dft算法. d立方概念应该都了解吧,就是说组合路径云总是一个输出可以表示为输入的多项式.最小项是d立方。非最小项是奇异立方.故障立方就是指让输出产生错误的输入立方，大家可以百度一下，这是dft基础算法.DFT基本的原理知识，微电子本科应该都有讲过，以前老师教的时候只讲原理，没结合工具和实际项目，都不知道DFT能做什么.

基本上是在组合路径上假设某点是stack错误。设计一组向量让输出某点唯一地反应这个stack错误.假设组合电路云输入来自scan寄存器。输出能被scan寄存器catch。这个stack错误会被atpg扫描出来,scan的test pattern就是通过shift clk移到指定的dff，作为逻辑锥的输入.

算法就是设计最少的正交向量.dft的这些算法，一般来说，只是做dft tool的人比较关注，例如mentor或synopsys的软件或算法工程师,对于广大dft 工程师，主要关心一件事,如何提高coverage

### Q18- 另外，有没有人在dft的基础上研究过postsilicon validation的，比如trace signal selection算法**

针对门级网表的选则. 就是利用单元门输出的状态倒推出输入的状态，再依次往前，从而发现门级网表中能够覆盖（推导出）最大范围的关键节点。这些节点就可以引出作为芯片的测试管脚，用来发现芯片测试过程中偶尔出现的错误。

### Q19-麻烦问大家个问题，做dft时数字逻辑做scan一般能保证覆盖率，但混合信号芯片内的数字模拟接口和大量的模拟控制寄存器怎么处理，也可以做scan吗？

1. 模拟macro的数字部分也有scanchain
2. 模拟部分会引出一些内部状态，不保证覆盖率。
3. 模拟内部逻辑要做scanchain的话是要使用带有scan的逻辑单元吗？这样感觉在流程上负担很大，意味着数字模拟接口信号个数要加倍吧
4. 模拟部分的内部一般不做scan 另外，模拟部分做scan，即使做了，这意义也不大啊，scan只能检测0或1的值，这模拟量是连续变化的，01对了，也不代表真对了了啊
5. 纯模拟部分scan出来的就是几个内部检测状态。例：bandgap输出应为1.2，检测到>1V
6. 模拟电路，有需要的话，一般会设计自己的bist电路，可以做calibration或是test。1V时候，给个高电平。scan出来。calibration最后给个结果/done
7. 我是说模拟部分的控制寄存器，因为模拟的人经常会把数字寄存器引进来后加一些模拟电路自己实现的简单逻辑，这些逻辑如何scan。另外就是有很多数模接口上的数据信号连线如何保证正确
8. 你举的这个例子，我觉得也是个合理的应用，我们这一般都会设计一个test mode，把bandgap的相关引脚，在这个测试模式下，引出片外
9. 做scanchain的时候，不需要改动macro，当然也改不了。
10. 解决办法：1、不管里面的逻辑了，例如一些小的模拟电路。2、里面做了scanchain，外面接上scan接口，例如PHY这样的大东西。
11. 像phy这种，模拟电路的很多控制寄存器可能根本没有加dff采过，因为没啥必要，模拟内部的很多组合逻辑实际无法scan
12. phy里面很多scan不到的地方……就……不管了
13. 有点没理解，你这的控制寄存器是数字电路吗？是的话，那寄存器本身就是dff啊，是dff就可以放在scan上啊。
14. 像PHY的高速串并转换这些手搭的高速dff，不做scan，影响性能。
15. 这些寄存器在数字部分肯定可以scan
16. 在模拟这边的不行。本身就是速度太高定制的，加scan就费了
- 对的，接口的连线也是不太容易用scan的方法来测的. 如果真的很care这些的coverage，，那就自己设计相应的专用测试模式，来测，无法用scan这种通用的方法
17. 嗯，可能这样比较靠谱，只是想保证一点覆盖率实现起来会麻烦
18. 我做过的soc上集成的高速接口，，都有自己的bist电路，可以把要观测的内部信号通过internal loopback或者external loopback到外面来测，而soc的dft 工程师，，必须设计相应的控制电路，来使能这些bist电路，并且设计相应的data path，把数据连到片外
- 是的，高速电路不timing 等非常紧张，通常用bist 或loopback 而不插scan 
19. 这些寄存器，本身是数字的还是模拟的
- 有些是模拟定制单元，就是模拟的人手搭的逻辑。对，模拟人员手搭的dff。类似的还有pll的前几级高速分频。这种东西在高速混合信号芯片中都是。还有大量的数模接口连线都无法测试覆盖

### 没有回答的问题

1. 大家做时序的时候是怎么处理scan enable 的 ？ 虽然我们可以在capture时候前后加 dummy cycle ,但是那么多寄存器skew差别太大，dummy cycle 太多也很浪费 
2. mbist 测试如何高效率的提高debug 废点手段。没钱买 diagnosis工具哈。
3. 我来问一个 rf在机台测试大家有啥心得 在cp和ft都会测吗 rf往往会出现lab和机台测试correlation不好的情况 如何控制或者界定量产的标准
4.  scan enable信号做pipline怎么样。我没有做过，snps的dft guide有这个 顺便请教一下
5. 如果测试模式信号容易受外界干扰影响，会不会考虑对DFT 的mode 或者scan enable信号做特殊处理？如果考虑抗干扰设计引入latch或组合逻辑，如何保障TMAX顺利通过？
6. scan mode下的 reconvergent clock有什么方式可以check？
