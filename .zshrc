export LANG=ja_JP.UTF-8

PROMPT='%F{green}[%n@%m]%f %~
%# '

# 補完
autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

bindkey -e # Emacs Bind

setopt no_beep
setopt share_history
setopt hist_reduce_blanks
setopt hist_ignore_all_dups
setopt print_eight_bit
setopt auto_menu
setopt extended_glob
setopt auto_pushd
setopt pushd_ignore_dups

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Colors
autoload colors
colors

# Aliases
# ----------
alias ls='ls -G -F -a'
alias la='ls -a'
alias ll='ls -hl'

# confirmation before delete / override
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# create subfolder
alias mkdir='mkdir -p'

# rails
alias rake='bundle exec rake'
alias be='bundle exec'

alias watch='watch --differences'


# cd したら ls する
function cd() {
  builtin cd $@ && ls;
}

# hostname 別の設定を読み込む。
# ex. ~/.zsh.hoge-no-macbook
[ -f ~/.zsh.`hostname -s` ] && source ~/.zsh.`hostname -s`
