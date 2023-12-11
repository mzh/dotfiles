HISTFILE=$HOME/.histfile
HISTSIZE=10000
KEYTIMEOUT=1
PROMPT="%n@%m:%~/ %# "
SAVEHIST=10000
ZLE_SPACE_SUFFIX_CHARS=$'&|'

setopt auto_cd
setopt no_beep
setopt complete_in_word
setopt extended_glob
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt interactive_comments
setopt no_nomatch

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

bindkey -v

bindkey '^R' history-incremental-pattern-search-backward

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'v' edit-command-line
bindkey -M vicmd '^N' down-history
bindkey -M vicmd '^P' up-history

bindkey -M viins ' ' magic-space
bindkey -M viins '^N' down-history
bindkey -M viins '^P' up-history

alias e=$EDITOR
alias q='exit'
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias gdiff='git diff --no-index'
alias l='ls -CF'
alias la='l -a'
alias ll='ls -Fhlrt'
alias lla='ll -a'

alias -s {md,markdown}=$EDITOR
alias -s tex=$EDITOR
alias -s txt=$EDITOR

cheat() {
  command -v curl > /dev/null 2>&1 && curl "cheat.sh/$1"
}

unzipd() {
  local filename="$1"
  local sans_extension=${1%.zip}
  unzip -d "$sans_extension" "$filename"
}

# dircolors
if command -v gdircolors > /dev/null 2>&1; then
  if [ -f $HOME/.dircolors ]; then
    eval "$(gdircolors -b $HOME/.dircolors)"
  else
    eval "$(gdircolors -b)"
  fi

  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

  alias grep='grep --color=auto'
  alias ls='gls --color=auto --literal'
fi
