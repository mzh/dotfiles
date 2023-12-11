export EDITOR=vim
export VISUAL=$EDITOR

[ -d "$HOME/bin" ] && export PATH=$PATH:$HOME/bin

# less
export PAGER=less
export LESS='-RX'
export LESSHISTFILE=-
export LESSHISTSIZE=0

# rg
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/rc"
