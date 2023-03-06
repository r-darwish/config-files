linuxbrew_dir="/home/linuxbrew/.linuxbrew"
dirs=("$linuxbrew_dir/bin" "${HOME}/.local/bin")

for dir in $dirs; do
  if [[ -d "$dir" ]] && [[ ":$PATH:" != *":$dir:"* ]]; then
    export PATH="$dir:$PATH"
  fi
done

autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

plugins_dir="$(dirname "$(realpath ~/.zshrc)")/zsh"
wiz_plugins="$plugins_dir/plugins-wiz.zsh"

source $plugins_dir/plugins.zsh
[ -f $wiz_plugins ] && source $wiz_plugins

if type "nvim" > /dev/null; then
  export EDITOR=nvim
else 
  export EDITOR=vi
fi

function e() {
  if [[ "$TMUX" ]]; then
    tmux split-window "$EDITOR $*"
  else
    command $EDITOR "$@"
  fi
}

if type "starship" > /dev/null; then
  eval "$(starship init zsh)"
fi

alias ks=kubectx
alias choco="sudo.exe choco"
alias l="exa -l --git"
alias ls='ls --color=auto'
alias t=tmux
alias lg=lazygit

function whatsapp() {
    local phone=$1
    if [[ ${phone:0:1} == "0" ]]; then
        phone=+972${phone:1}
    fi

    open "https://web.whatsapp.com/send?phone=$phone&text&type=phone_number&app_absent=0"
}

function cdf () {
  cd $(dirname $1)
}

function targs() {
    while read -r line; do
        tmux new-window -n "$line"
        tmux send-keys "$@ $line" C-m
    done
}

function nd() {
  curl \
  -H "Title: Process done in $(hostname)" \
  -d "" \
  ntfy.sh/$NTFY_TOPIC
}


[ -d $linuxbrew_dir ] && FZF_BASE=$linuxbrew_dir/opt/fzf
zvm_after_init_commands+=("source $plugins_dir/plugins-post.zsh")
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT

