# 极刊・ Tcl 工作环境搭建 Zsh Tmux Vim 三剑客

## Microsoft WSL install

https://docs.microsoft.com/en-us/windows/wsl/install-win10

## Install Xming

http://www.straightrunning.com/XmingNotes/

## Linuxtoy

https://linuxtoy.org/archives/zsh.html

## Learning Shell Scripting with Zsh

https://www.goodreads.com/book/show/20609696-learning-shell-scripting-with-zsh

## Install zsh

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

## zplug

``` zsh
zplug "zsh-users/zsh-completions"

zplug "zsh-users/zsh-syntax-highlighting", \
    defer:2, \
    from:github

zplug "wting/autojump", \
    from:"github", \
    as:command
```

## Tmux 2: Productive Mouse-Free Development
https://www.goodreads.com/book/show/32302568-tmux-2

## Install tmux

```zsh
sudo apt-get update
sudo apt-get install tmux
tmux -V

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Setup tpm

https://github.com/tmux-plugins/tpm

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

```conf
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'jimeh/tmux-themepack';
set -g @plugin 'tmux-plugins/tmux-resurrect'
```

## The VimL Primer: Edit Like a Pro with Vim Plugins and Scripts

https://www.goodreads.com/book/show/24934861-the-viml-primer

## Install gvim

```zsh
sudo apt-get install vim-gtk
```

## tclreadline

http://tclreadline.sourceforge.net/

```zsh
sudo apt-get install tclreadline
```

## nagelfar

https://github.com/vim-syntastic/syntastic

http://nagelfar.sourceforge.net/
