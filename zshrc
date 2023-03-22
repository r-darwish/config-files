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

_es_completion() {
  local paths=()
  for d in $(echo "$PATH" | tr ':' ' '); do
    while IFS= read -r line; do # Whitespace-safe EXCEPT newlines
      paths+=("$line")
    done <<< $(find $d -type f -perm +111 -user "$(whoami)" -execdir basename '{}' ';' 2>/dev/null)
  done

  compadd "${paths[@]}"
}

es() {
  local script
  script=$(which "$1" 2>/dev/null)

  if [ ! -f "${script}" ]; then
    script="$HOME/.local/bin/$1"
    touch "$script" && chmod +x "$script" || return 1
  fi

  e "$script"
}

unalias gcm
gcm() {
  git checkout develop || git checkout main || git checkout master
}

compctl -K _es_completion es
compdef _es_completion es

e() {
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
alias pf="fzf --preview='bat --color=always {}' --bind ctrl-p:preview-page-up,ctrl-n:preview-page-down --preview-window=70%,border-double,top"
alias st="starship toggle"
alias cj="bat -l json"
alias c="bat"
alias nvs="nvim --listen /tmp/nvim"

nvc() {
  nvim --server /tmp/nvim --remote-send ":e $(realpath $1)<CR>"
}


whatsapp() {
    local phone=$1
    if [[ ${phone:0:1} == "0" ]]; then
        phone=+972${phone:1}
    fi

    open "https://web.whatsapp.com/send?phone=$phone&text&type=phone_number&app_absent=0"
}

cdf () {
  cd $(dirname $1)
}

targs() {
    while read -r line; do
        tmux new-window -n "$line"
        tmux send-keys "$@ $line" C-m
    done
}

nd() {
  curl \
  -H "Title: Process done in $(hostname)" \
  -d "" \
  ntfy.sh/$NTFY_TOPIC
}


[ -d $linuxbrew_dir ] && FZF_BASE=$linuxbrew_dir/opt/fzf
zvm_after_init_commands+=("source $plugins_dir/plugins-post.zsh")
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
setopt AUTO_PUSHD

