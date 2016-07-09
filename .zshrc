# Shell variables {{{
HISTFILE=$HOME/.histfile
HISTSIZE=10000
KEYTIMEOUT=1
PROMPT="%n@%m:%~/ %# "
SAVEHIST=10000
ZLE_SPACE_SUFFIX_CHARS=$'&|'

# }}}
# Options {{{
setopt auto_cd
setopt no_beep
setopt complete_in_word
setopt extended_glob
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt interactive_comments
setopt no_nomatch

# Completion
zstyle ':completion:*' completer _expand _complete _ignored _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' verbose true

zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

autoload -Uz compinit
compinit

# }}}
# Bindings {{{
bindkey -v

bindkey '^R' history-incremental-search-backward

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line
bindkey -M vicmd '^N' down-history
bindkey -M vicmd '^P' up-history

bindkey -M viins ' ' magic-space
bindkey -M viins '^N' down-history
bindkey -M viins '^P' up-history

# }}}
# Aliases {{{
alias e=$EDITOR
alias q='exit'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias l='ls -CF'
alias la='l -a'
alias ll='ls -Fhlrt'
alias lla='ll -a'
alias mi='mv -i'
alias ri='rm -i'
alias xc='xclip -selection clipboard'

if [ "$EDITOR" = "nvim" ]; then
  alias vimdiff='nvim -d'
  alias view='nvim -R'
fi

alias -s {md,markdown}=$EDITOR
alias -s tex=$EDITOR
alias -s txt=$EDITOR
alias -s {jpg,jpeg}='background feh'
alias -s png='background feh'
alias -s pdf='zathura --fork'

background() {
  "$@" &
}

# }}}
# Auxiliary files {{{
# dircolors
if command -v dircolors > /dev/null 2>&1; then
  if [ -f $HOME/.dircolors ]; then
    eval "$(dircolors -b $HOME/.dircolors)"
  else
    eval "$(dircolors -b)"
  fi

  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

  alias grep='grep --color=auto'
  alias ls='ls --color=auto'
fi

# fzf
if [ -f $HOME/.fzf.zsh ]; then
  source $HOME/.fzf.zsh

  command -v ag > /dev/null 2>&1 && export FZF_DEFAULT_COMMAND='ag -g "" --hidden --ignore .git'
  export FZF_DEFAULT_OPTS='--multi --color=16 --inline-info --tiebreak=end'
  export FZF_CTRL_R_OPTS='--sort'
  command -v tree > /dev/null 2>&1 && export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -n $LINES'"
fi

# }}}
