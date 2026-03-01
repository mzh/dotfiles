export EDITOR=vim
export VISUAL=$EDITOR

[ -d "$HOME/bin" ] && export PATH=$PATH:$HOME/bin

export SHELL_SESSIONS_DISABLE=1

# less
export PAGER=less
export LESS='-RX'
export LESSHISTFILE=-
export LESSHISTSIZE=0

# python
export PYTHON_HISTORY=/dev/null

# rg
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/rc"
