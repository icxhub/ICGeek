# 极客说-EDA 在云中漫步主题讨论
###### 作者：群聊笔记

###### 编辑: 高原

### 友情提示 ： 
> 
> 1. IC 极客之家是由IC 行业的几位工程师发起，每周群内发起涉及IC 设计各领域的主题头脑风暴，群友也可随机在群内发起提问，入群请加微信号 sgsphoto
> 
>  ![image](D:1.jpg)  

>  
> 2. 极客专栏，极客说，极客问答文章请关注公众号icgeeks.
> 3. 极客说与极客问答整理及信息来源以群内聊天记录为准，内容无法一一确认过滤，为保护群友个人隐私，整理目前暂时采用匿名方式，未尽之处请联系群主高原(sgsphoto)，做修改更新或者删除。
> 4. 请新入群群友于群公告处阅读群规，并在接下来的讨论中积极参与。
> 5. 我们从第一篇文章就开始托管于github，https://github.com/icxhub/ICGeek 采用知识共享协议，每篇文章都有原本链的DNA唯一标识，实验数据也在里面，欢迎大家围观。文章版权所有，合作联系微信号 sgsphoto.

---

#### Q 有没有人，试过对FPGA的sof或者jic文件加密的？就是说生成的sof或者jic文件只能用在一个FPGA上，不能用在其他的FPGA上
>
1#  Altera好像有一个芯片指纹的IP来着,好像是根据制造工艺算出的一个唯一数

2#  stratix III 200这个FPGA有加密功能吗？主要是想防止客户抄板。

3# 防抄板可以用外部的加密芯片

4# xilinx 的fpga 有efuse key,altera 应该也有类似技术

5# fpga代码发现外部加密芯片有问题就停止工作, 类似token的原理

6# 还有一种是专门的Id 芯片，每个芯片有全球唯一的ID fpga 再加逻辑控制，就可以，还可以追踪，

7# [Chip ID Intel FPGA IP Cores User Guide](https://www.altera.com/documentation/sam1412052977775.html)

8# https://www.altera.com.cn/products/fpga/features/stx-design-security.html  设计安全性
随着越来越多的系统采用 FPGA 来实现核心功能，保护 FPGA 中的设计和宝贵的知识产权 (IP) 变得更加重要了。Altera 的 Stratix 系列和 Arria II GX FPGA 同时提供易失和非易失设计安全功能，保护您的设计不被复制、逆向剖析和篡改，而 Altera 的 Cyclone III LS FPGA 型号支持易失设计安全。