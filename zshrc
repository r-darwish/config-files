linuxbrew_dir="/home/linuxbrew/.linuxbrew"
dirs=("$linuxbrew_dir/bin" "${HOME}/.local/bin" "$(dirname "$(readlink -f "$HOME/.zshrc")")/bin")

for dir in $dirs; do
  if [[ -d "$dir" ]] && [[ ":$PATH:" != *":$dir:"* ]]; then
    export PATH="$dir:$PATH"
  fi
done

autoload -Uz compinit
compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'

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

unalias gcd
git_checkout_default() {
  git checkout "$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')"
}
alias gcd=git_checkout_default
alias gcdu="gcd && gup"

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

if type "zoxide" > /dev/null; then
  eval "$(zoxide init zsh)"
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

bi() {
  local criteria=$1
  if [[ -z "$criteria" ]]; then
    echo "No criteria provided" >&2
    return 1
  fi

  brew search "$criteria" | grep -v '^$' | fzf --preview='HOMEBREW_COLOR=1 brew info {}' | xargs brew install
}

cdf () {
  cd "$(dirname "$1")" || return 1
}

gitroot() {
  local dir=${1:-.}
  dir=$(readlink -f "$dir") || return 1
  [[ -f "$dir" ]] && dir=$(dirname "$dir")

  (cd "$dir" && git rev-parse --show-toplevel)
}

rcode() {
  code --remote "ssh-remote+$1" "$2"
}

gitback() {
  git rev-list -n 1 --before="$1" HEAD
}

targs() {
    while read -r line; do
        tmux new-window -n "$line"
        tmux send-keys "$@ $line" C-m
    done
}

ntfy() {
  curl \
  -H "Title: $1" \
  -d "$2" \
  ntfy.sh/$NTFY_TOPIC > /dev/null 2> /dev/null
}

bindkey -e
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line

[ -d $linuxbrew_dir ] && FZF_BASE=$linuxbrew_dir/opt/fzf
source $plugins_dir/plugins-post.zsh
setopt AUTO_PUSHD

if type "atuin" > /dev/null; then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

alias hcode="sgpt --code --chat code"
alias haws="sgpt --shell --role aws"
alias haz="sgpt --shell --role az"
alias hgo="sgpt --chat go_code --role go"
alias hpy="sgpt --chat py_code --role py"
alias hsh="sgpt -s"
alias gbsn="git bisect run"
