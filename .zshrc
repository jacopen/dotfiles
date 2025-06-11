# thanks to http://blog.veryposi.info/server/server-setup/mac-product-env-zsh/
# users generic .zshrc file for zsh(1)
 
## Environment variable configuration
#
# LANG
#
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
case ${UID} in
0)
    LANG=C
    ;;
esac

# vcs_info
autoload vcs_info
# gitのみ有効にする
zstyle ":vcs_info:*" enable git
# commitしていない変更をチェックする
zstyle ":vcs_info:git:*" check-for-changes true
# ブランチ情報表示
zstyle ":vcs_info:git:*" formats "%c%u(%b) "
# gitリポジトリに対して、コンフリクトなどの情報を表示する
zstyle ":vcs_info:git:*" actionformats "%c%u<%a>(%b) "
# addしていない変更があることを示す文字列
zstyle ":vcs_info:git:*" unstagedstr "<U>"
# commitしていないstageがあることを示す文字列
zstyle ":vcs_info:git:*" stagedstr "<S>"

# vcs_infoの出力に独自の出力を付加する
my_vcs_info () {
  vcs_info
  echo $vcs_info_msg_0_
}

# プロンプト定義の中で置換を使用する
setopt prompt_subst

# プロンプト定義
VCS=$'$(my_vcs_info)'
 
## Default shell configuration
#
# set prompt
#
autoload colors
colors

COLOR=("red" "blue" "white" "green" "cyan" "yellow" "cyan" "red" "green" "blue" "white" "yellow")
host_color=${COLOR[${#${HOST}}]}

case ${UID} in
0)
    PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') %{${fg[red]}%}%n@%m%#%{${reset_color}%} "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
#    RPROMPT="%{${fg[green]}%}[%~:%T]%{${reset_color}%}"
    ;;
*)
    #PROMPT="[%T] %{${fg[red]}%}%n@%m %~ (・Θ・)%{${reset_color}%} ${VCS}"
    PROMPT="[%T] %{${fg[red]}%}%n@%m %1~ (・Θ・)%{${reset_color}%} ${VCS}"
    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
#    RPROMPT="%{${fg[green]}%}[%~:%T]%{${reset_color}%}"
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%{${fg[${host_color}]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
esac
 
# auto change directory
#
setopt auto_cd
 
# auto directory pushd that you can get dirs list by cd -[tab]
#
setopt auto_pushd
 
# command correct edition before each completion attempt
#
#setopt correct
#setopt correct_all
 
# compacked complete list display
#
setopt list_packed
 
# no remove postfix slash of command line
#
setopt noautoremoveslash
 
# no beep sound when complete list displayed
#
setopt nolistbeep
 
# TABで順に保管候補を切り替える
#
setopt auto_menu
 
# 保管候補一覧でファイルの種別をマーク
#
setopt list_types
 
# = 以降でも補完できるようにする
#
setopt magic_equal_subst
 
# 補完時の日本語を正しく表示する
#
setopt print_eight_bit
 
# 重複するコマンド行は古い方を削除する
#
setopt hist_ignore_all_dups
 
# 履歴を追加
#
setopt append_history
 
# 履歴をインクリメンタルに追加
#
setopt inc_append_history
 
# 補完時に文字列末尾へカーソル移動
#
setopt always_to_end
 
# あいまい補完時に候補表示
#
setopt auto_list
 
# historyコマンドをヒストリリストから取り除く
#
setopt hist_no_store
 
# コマンドの空白を削る
#
setopt hist_reduce_blanks
 
# 先頭が空白だった場合はログに記述しない
#
setopt hist_ignore_space
 
# ビープ音を出さない
#
setopt no_beep
 
# ヒストリを呼び出してから編集可能な状態にする
#
setopt hist_verify
 
# 保管候補のカーソル選択を有効にする
#
zstyle ':completion:*:default' menu select=1
 
# 補完の時に大文字小文字を区別しない(但し、大文字を打った場合は小文字に変換しない)
#
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
 
 
## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a gets to line head and Ctrl-e gets
#   to end) and something additions
#
bindkey -e
bindkey "^[[1~" beginning-of-line # Home gets to line head
bindkey "^[[4~" end-of-line # End gets to line end
bindkey "^[[3~" delete-char # Del
 
# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end
 
# reverse menu completion binded to Shift-Tab
#
bindkey "\e[Z" reverse-menu-complete
 

# Forward - back word
bindkey '^F'   forward-word
bindkey '^B'   backward-word

# Command history configuration

HISTFILE=${HOME}/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
 
 
## Completion configuration
#
fpath=(${HOME}/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit
 
 
## zsh editor
#
autoload zed
 
 
## Prediction configuration
#
#autoload predict-on
#predict-on
 
 
## Alias configuration
#
# expand aliases before completing
#
setopt complete_aliases     # aliased ls needs if file/dir completions work
 
alias where="command -v"
alias j="jobs -l"
 
case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac
 
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
 
alias du="du -h"
alias df="df -h"
 
alias su="su -l"
 
# personal alias
alias g="git"
alias v="vim"
alias r="rails"
 
## terminal configuration
#
case "${TERM}" in
screen)
    TERM=xterm
    ;;
esac
 
case "${TERM}" in
xterm|xterm-color)
    export LSCOLORS=gxfxcxdxbxegedabagacad
    #export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    #zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
xterm|xterm-256color)
    export LSCOLORS=gxfxcxdxbxegedabagacad
    #export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    #zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm-color)
    stty erase '^H'
    export LSCOLORS=gxfxcxdxbxegedabagacad
    export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
kterm)
    stty erase '^H'
    ;;
cons25)
    unset LANG
    export LSCOLORS=gxfxcxdxbxegedabagacad
    export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
jfbterm-color)
    export LSCOLORS=gxfxcxdxbxegedabagacad
    export LS_COLORS='di=01;36:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors 'di=;36;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac
 
# set terminal title including current directory
#
case "${TERM}" in
xterm|xterm-color|kterm|kterm-color|ttym)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    ;;
esac
 
 
# load user .zshrc configuration file
#
[ -f ${HOME}/.zshrc.mine ] && source ${HOME}/.zshrc.mine
 

alias grill='ssh'

# http://logrepo.blogspot.com/2010/12/zsh.html
export PATH=/opt/local/bin:/opt/local/sbin:~/bin:$PATH

for filepath in $(ls ${HOME}/dotfiles/zsh)
do
  source ${HOME}/dotfiles/zsh/${filepath}
done

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/kkusama/.sdkman"
[[ -s "/Users/kkusama/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/kkusama/.sdkman/bin/sdkman-init.sh"

source <(kubectl completion zsh)

if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    export TERM=xterm-256color
fi

# Added by Windsurf
export PATH="/Users/kkusama/.codeium/windsurf/bin:$PATH"

# Android SDK
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=~/.npm-global/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/private/tmp/google-cloud-sdk/path.zsh.inc' ]; then . '/private/tmp/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/private/tmp/google-cloud-sdk/completion.zsh.inc' ]; then . '/private/tmp/google-cloud-sdk/completion.zsh.inc'; fi
