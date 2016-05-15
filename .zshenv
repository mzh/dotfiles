if command -v nvim > /dev/null 2>&1; then
  EDITOR=nvim
else
  EDITOR=vim
fi
export EDITOR
export VISUAL=$EDITOR

[ -d "$HOME/bin" ] && export PATH=$HOME/bin:$PATH

# less
export PAGER=less
export LESS='-RX'
export LESSHISTFILE=-
export LESSHISTSIZE=0

# Disable GTK accessibility bridge
export NO_AT_BRIDGE=1
