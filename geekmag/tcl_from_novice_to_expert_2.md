# 极刊・ Tcl 工作环境搭建 Zsh Tmux Vim 三剑客

![building](../res/img/building.jpg)

**Steve 陪你读 IC**

- 用我的文字帮你把书读薄
- 用我的经验帮你把书读厚

**往期链接**

1. [Tcl/Tk From Novice to Expert](tcl_from_novice_to_expert_0.md)
2. [语言选择之路 & Tcl 在工作中的占比](tcl_from_novice_to_expert_1.md)

**看完本文**

我不是在讲怎么装 Tcl，而是讲 Zsh Tmux 和 Vim 构建的 Linux Tcl 工作环境，哪些基础的好插件可用。

- **Zsh** 是一个很好地工具，支持很多特性，但是公司一般有统一的 Shell 管理，Zsh 自用是很好的。
- **Tmux** 的出项取代了我是用 Screen，它强大到可以做很多自动化工作，还可以不同的 terminal 之间进行交互。
- **Vim** 只是我第一个用的编辑器，这个东西你第一次用了什么（Vim 或者 Emacs）估计就会一直用。

---

## Ubuntu in Win10

我的环境是基于 Win10 Ubuntu 的，GUI 方案使用 Ximg。

Tcl 是 Ubuntu 自带的，如果是 Windows，可以安装 windows 上的发行版。

一般都是装 ActiveState 的发行版，包含了大多数的库和扩展。

![zsh](../res/img/zsh_zeta.png)

### 查看安装要求和设置准备

并不是所有 Win10 都能装 Linux Subsystem 的，访问 Windows Store 就会帮你自动检测你是不是符合安装要求。

Win 系统版本必须是 14393 以上，系统类型必须是 64 位操作系统。

https://docs.microsoft.com/en-us/windows/wsl/install-win10

这是 Microsoft Store 里检测的系统要求。

![WSL Requirement](../res/img/wsl_requirement.png)

### 安装 Ubuntu

进入商店搜 Ubuntu 或者 Linux 直接安装。

### 安装 Xmimg

http://www.straightrunning.com/XmingNotes/

对于 Linux 的图形来说，需要一个 Display 来作为 GUI 的显示。

安装 Xmimg 并启动。

在 Ubuntu 中设置 DISPLAY 环境变量为 ":0.0"。

## 安装 Zsh Tmux Vim 和相关插件

现在的工具或者流程很少不支持插件的，很多工具本身就是个插件管理器，功能都是靠插件搭起来的。所以我的 Tcl 专题不是只讲 Tcl，在之后某一起会专门讲讲一般插件架构的设计思路以及我在 Tcl 里怎么设计插件的。

这个系列还会放出一些插件的讲解，我觉得好的插件应该去充分使用，有些还可以细细研究。

### Zsh

我最开始认识 Zsh 是在 Linuxtoy，这个博客一直有更新，最近更新频率变缓了。

https://linuxtoy.org/archives/zsh.html

> 注：公众号无法加外链，大家可以 48 小时后查看小程序中有链接的版本。
> 
> 更快方法是转发本文并截图发送至公众号，我们会按顺序发出文中提到的脚本源文件和链接等资源。

学习推荐：

- Learning Shell Scripting with Zsh
- https://www.goodreads.com/book/show/20609696-learning-shell-scripting-with-zsh

![Learning Shell Scripting with Zsh](../res/img/gr_cover_20609696.jpg)

``` zsh
# install zsh
sudo apt-get install zsh
chsh -s /bin/zsh

# install oh-my-zsh
sudo apt-get install git
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# install zsh plugin
sudo apt-get install autojump
echo ". /usr/share/autojump/autojump.sh" >> ~/.zshrc

# install zsh-syntax-highlighting
mkdir -p ~/.dotfiles/shell
cd ~/.dotfiles/shell/
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git 
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc

# Set theme

# open ~/.zshrc
# find ZSH_THEME
# Change the theme

```

zsh plug-in 可以直接使用 zplug 安装，将 zplug 配置写入 zshrc。

``` zsh
zplug "zsh-users/zsh-completions"

zplug "zsh-users/zsh-syntax-highlighting", \
    defer:2, \
    from:github

zplug "wting/autojump", \
    from:"github", \
    as:command
```

### Tmux

Tmux 一开始是同事推荐的，然后也是看到 Linuxtoy 上有介绍，进而想去了解更多，慢慢觉得这个太给力。

学习推荐

- Tmux 2: Productive Mouse-Free Development
- https://www.goodreads.com/book/show/32302568-tmux-2

![Tmux 2: Productive Mouse-Free Development](../res/img/gr_cover_32302568.jpg)

```zsh
sudo apt-get update
sudo apt-get install tmux
tmux -V

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

配置 TPM （Tmux-Plugin-Management）需要把下面一段放入~/.tmux.conf。

``` zsh
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'git@github.com/user/plugin'
# set -g @plugin 'git@bitbucket.com/user/plugin'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```

https://github.com/tmux-plugins/tpm

配置完 TPM, 你可以把下列插件列表加入 zshrc 文件。

```conf
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'jimeh/tmux-themepack';
set -g @plugin 'tmux-plugins/tmux-resurrect'
```

![Tmux](../res/img/tmux.png)

**使用场景介绍**

1. 多个 terminals 一个窗口管理
2. 一个 terminal 多个 panels
3. resurrect 可保存当前的窗口布局和目录
4. 自动运行一些命令登陆项目（需 expect）和恢复工作环境
5. 自动化，从其他 terminal 发送命令到任意 terminal
6. 玩法还有更多等你发现

### Vim (Neovim)

阅读推荐

- The VimL Primer: Edit Like a Pro with Vim Plugins and Scripts
- https://www.goodreads.com/book/show/24934861-the-viml-primer

![The VimL Primer: Edit Like a Pro with Vim Plugins and Scripts](../res/img/gr_cover_24934861.jpg)

如果之后的系列有机会也会拿 Vim 的插件来做介绍，以及改写某些插件功能。后面结合遇到的实例会讲一些插件的使用和编写。

```zsh
sudo apt-get install vim-gtk
```

### tclreadline

Tclreadline 可以用 Tab 键去匹配命令，Tab 键可以查看变量名，命名空间，以及 Array 里的 key。

还可以自定义 Prompt。

http://tclreadline.sourceforge.net/

```zsh
sudo apt-get install tclreadline
```

![Tclreadline](../res/img/tclreadline.png)

### nagelfar

VIm 我使用了 syntastic 这个语法检查工具，并配置好了 nagelfar 的支持。杜绝一些拼写和与简单的语法错误，出错更多的是逻辑不正确，也是提高效率，节约时间的表现。

https://github.com/vim-syntastic/syntastic

http://nagelfar.sourceforge.net/

**Features**

- Written in pure Tcl/Tk. No compilation. If you can run Tcl you can run Nagelfar.
- Extendible. You can add to the syntax database, or let the tool use Tcl’s introspection to extract syntax information from any Tcl interpreter. Thus you can test scripts for applications using Tcl as script language.
- Plugins. Even more extendible through plugins that can hook up at certain points in the check flow and do custom checking.
- Severity level filter and glob matching filters to remove errors known to be OK.
- View and edit the checked source directly in Nagelfar.
- Inline comments can help Nagelfar do a better job.
- Code coverage instrumentation. Provides help for simple code coverage analysis.

## 加入 IC 极客群

本群由 IC 行业的几位工程师发起，以公益，开源，分享为宗旨，致力于推广 IC 极客文化，组织大家深入交流 IC 设计领域知识，经验及方法学，打造 IC 设计圈的思想国。

群也欢迎群友或 IC 极客玩家随机发起不固定主题的讨论。欢迎联系文末的微信号小主入群参与分享交流。
![入群](../res/img/group_invitation.png)

## 支持 （Donate）

![Donate](../res/img/support_icgeek.jpg)