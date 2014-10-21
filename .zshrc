export LANG=ja_JP.UTF-8

# see http://yoshiko.hatenablog.jp/entry/2014/04/02/zshのプロンプトにgitのステータスをシンプル可愛く
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' max-exports 6 # formatに入る変数の最大数
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%b@%r' '%c' '%u'
zstyle ':vcs_info:git:*' actionformats '%b@%r|%a' '%c' '%u'
setopt prompt_subst
function vcs_echo {
    local st branch color
    STY= LANG=en_US.UTF-8 vcs_info
    st=`git status 2> /dev/null`
    if [[ -z "$st" ]]; then return; fi
    branch="$vcs_info_msg_0_"
    if   [[ -n "$vcs_info_msg_1_" ]]; then color=${fg[green]} #staged
    elif [[ -n "$vcs_info_msg_2_" ]]; then color=${fg[red]} #unstaged
    elif [[ -n `echo "$st" | grep "^Untracked"` ]]; then color=${fg[blue]} # untracked
    else color=${fg[cyan]}
    fi
    echo "%{$color%}(%{$branch%})%{$reset_color%}" | sed -e s/@/"%F{yellow}@%f%{$color%}"/
}
PROMPT='%F{green}[%n@%m]%f%F{yellow} %~%f `vcs_echo`
%(?.$.%F{red}$%f) '

# 補完
autoload -Uz compinit
compinit
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Emacs Key Bind
bindkey -e

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
# わかりやすくする
alias la='ls -a'
alias ll='ls -hl'
alias watch='watch --differences'

# confirmation before delete / override
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# create subfolder
alias mkdir='mkdir -p'

# rails
alias rake='bundle exec rake'
alias be='bundle exec'

# OS 別の設定
# see https://gist.github.com/mollifier/4979906
case ${OSTYPE} in
    darwin*)
        #Mac用の設定
        export CLICOLOR=1
        alias ls='ls -G -F'
        ;;
    linux*)
        #Linux用の設定
        alias ls='ls -F --color=auto'
        ;;
esac

# cd したら ls する
function cd() {
  builtin cd $@ && ls;
}

