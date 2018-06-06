# 五分钟理解技术名词：配置管理

![Picture](../res/img/subject_conf.jpg)

<img src="https://yb-img.oss-cn-shanghai.aliyuncs.com/badges/1OPU74RVIRAYRS2VHT50ZXK2IQXX41FMTBSMS353KAP34OM0SG.png" style="float:right;">

本文经「原本」原创认证，作者Steve Bee，访问yuanben.io查询【[1OPU74RV](https://yuanben.io/article/1OPU74RVIRAYRS2VHT50ZXK2IQXX41FMTBSMS353KAP34OM0SG)】获取授权信息。

## 引导语

Alice 在IC 极客群里谈到了配置管理，那我也来谈一谈。配置的设计更多的是再软件的管理和使用中被提及，而IC 流程中，配置也是需要的，但是上升到配置管理很多时候并不是那么被人看好，但是配置管理可以帮助你提高效率，减少交流误差，自动化流程，内容驱动管理等等。

## 关于IC 配置管理

IC 工程师对配置文件肯定不会陌生，比如 EDA 工具一般有三处优先级不同的配置文件，IC Flow 也都会有一个定义公共信息的配置，今天来详细剖析下我对“配置管理”的理解与思考。有很多开源的配置管理方法与实践，而 IC 行业有区别于一般开发或者软件的，有自己的场景。

工具的命令需要和工具本身的语言契合，比如可以使用 Tcl 直接做配置，而有些项目和设计相关的需要和其他管理软件进行数据交流，Tcl 显得不是那么方便。本文我们一起来讨论下适合IC 场景的配置管理。

从配置的获取方式可以分为，统一配置管理和分布式管理配置，和区块链的概念很像，就是中央管理和去中心化，这个话题各行各业都在讨论，比如svn 和git，各国货币和比特币等。对于IC 的配置管理，很大程度上希望使用统一配置管理，一个项目大家工作在同一个频道下效率会更高，但是每个模块也希望有自己的个性化设置，类似说设计分块，配置需要独立，而且某个模块下好的或者说修正的设置可以共享给整个项目使用，这个又有点分布式的思想。

## 基本的配置需要考虑哪些方面

- 角色配置

角色配置是表达整个组织关系，人员管理，项目中的人员调配。一般这个部分由 Manager 指定谁做什么模块，谁做什么功能，就像演戏一样，导演需要物色合适的人选进行整个角色的分配。

角色很多时候会有不同的系统控制，配置就需要灵活，可导入，可定期更新，或者访问指定的API 直接调用。

- 项目配置

多用于项目的管理和协调，更多得面向各个资源的调配和统一的信息共享，为项目管理提供基础。所有数据都可以多平台访问，方便了不同角色（项目经理，开发经理，开发人员，技术顾问等）的介入。

- 设计配置

具体到开发人员，和具体的设计相关的内容，在多工具环境下，以及数据流转的情况下这个显得特别重要，设计的基础数据做为配置可以在多个步骤之间保持一致。

- 工具配置

配合工具，有些策略性的东西是可以提取出来作为一个标准，有些是完全和具体的工具相关的。这些配置也分为项目公共部分和用户本地部分。

- 专项配置

对于像IP，库等平台，需要专项配置，这些可通过配置的扩展来书写，平台定义了配置的格式以及使用配置的方法，扩展可以更好地适应更多的环境，更方便地进行数据交互。

## xConf 实现与特点

![xConf 实现图](../res/img/conf_structure.png)

IC Configure System “xConf” 设计考虑：

- 基本特性：
  - 配置信息简单可读，适合IC 工程师
  - 入口丰富，Web，Server，Tool Shell 都可以进行操作
  - 主从模式，方便统一管理以及本地定制
  - 工具支持丰富，Tcl 做为主力接口
  - 提供API 调度

- 增强特性
  - 握手协议 - 本地配置需要有专门的握手key 来和项目协议进行数据交换
  - 提供更新策略 - 区分大版本和日常小更新，更丰富的更新Rule
  - 无缝集成接口 - 通过内容转换完成无缝接口
  - 专为IC 的Hierarchy 做的配置设计，统一管理
  - 继承和反馈机制，解决数据的同步忧虑
  - 插件扩展 - 丰富应用场景

## 应用场景复现

当我们决定创建 IC 项目开始，我们就在为项目做配置了，最关键的名字需要想好，Schedule，工艺等都要落实。然后不断地有输入进来，有时候可以说配置管理并不是纯粹的配置，而是信息化数据的管理。比如对于xConf 的一个扩展，Work Flow and Content Automation，配置扮演的角色就是定义工作流，一切流转过程均由内容（配置）来驱动，我会以此为场景做为插件扩展的例子。

### 场景一： 创建项目

当我们决定要立项的时候，前台会收集项目基本信息，这些信息作为项目的基准信息存入数据库，而某些信息会被写到配置中，比如项目的名字，工艺的选择，Signoff 的Corners等。立项的过程也是配置收集的过程，数据信息化的过程。当项目建立以后，工程师需要建立工作目录，可以根据立项时候的配置，比如项目路径，文档路径，项目仓库等配置信息，一步生成各种工作环境，对于IC 数字设计，很多工具都要使用流程，而项目建立的时候我们可以指定获取流程的方式而方便整个项目ready to run.

### 场景二： 开始设计

开始做设计了，很多内容需要做本地的hack，而继承的机制允许本地采用增量的方式进行数据读取，本地设置将会覆盖项目设置，本地设置始终只是一个项目设置的子集。这个方式提高了本地工作的自由度，也紧密联系了本地和项目的配置。比如项目Singoff 的Uncertainty 为0.8ns，那么本地APR 设置如果有1.2ns 的Uncertainty，APR 流程以本地为主，数据的同步必须通过Rule，而且必须要在用户知晓的情况下主动进行。

### 场景三： 配置插件

这里有一个插件的实例，Work Flow & Content Automation，流程的进行，内容的流转都是基于配置。根据内容去匹配配置状态，配置中规定了各个状态，包含了该状态下一个状态，下一个动作等信息，那么一个流程管理和内容自动化系统就搭建起来了。

## 下期主题预告

下期 IC 极客群关注的话题为：效率，技术面和软件能。

IC 极客内交流的方式为：每周二，五定期推送固定主题的干货文章，发起相关主题的群内头脑风暴和技术分享。

## 加入 IC 极客群

本群由IC 行业的几位工程师发起，以公益，开源，分享为宗旨，致力于推广IC 极客文化，组织大家深入交流IC 设计领域知识，经验及方法学，打造IC 设计圈的思想国。群也欢迎群友或IC 极客玩家随机发起不固定主题的讨论。欢迎联系文末的微信号小主入群参与分享交流。

![入群](../res/img/wechat_sgsphoto.jpg)