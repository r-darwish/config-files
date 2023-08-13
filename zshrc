linuxbrew_dir="/home/linuxbrew/.linuxbrew"
bin_dirs=("$linuxbrew_dir/bin" "${HOME}/.local/bin" "$(dirname "$(readlink -f "$HOME/.zshrc")")/bin")
completion_dirs=("$linuxbrew_dir/etc/bash_completion.d" "/usr/local/etc/bash_completion.d")

for dir in $bin_dirs; do
  if [[ -d "$dir" ]] && [[ ":$PATH:" != *":$dir:"* ]]; then
    export PATH="$dir:$PATH"
  fi
done

autoload -Uz compinit
compinit

for dir in $completion_dirs; do
  if [[ -d "$dir" ]]; then
    autoload bashcompinit
    bashcompinit
    source $dir/*
  fi
done

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group ',' '.'

plugins_dir="$(dirname "$(realpath ~/.zshrc)")/zsh"
wiz_plugins="$plugins_dir/plugins-wiz.zsh"

source $plugins_dir/plugins.zsh
[ -f $wiz_plugins ] && source $wiz_plugins

if type "hx" > /dev/null; then
  export EDITOR=hx
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

if type "broot" > /dev/null; then
  eval "$(broot --print-shell-function zsh)"
fi

if type "aws_completer" > /dev/null; then
   complete -C "$(where aws_completer)" aws
fi

alias ks=kubectx
alias choco="sudo.exe choco"
alias l="exa -l --git"
alias ls='ls --color=auto'
alias lg=lazygit
alias pf="fzf --preview='bat --color=always {}' --bind ctrl-p:preview-page-up,ctrl-n:preview-page-down --preview-window=70%,border-double,top"
alias st="starship toggle"
alias cj="bat -l json"
alias c="bat"
alias tidy="go mod tidy"

s() {
  (
     echo -ne "\033]0;📡 ${@[$#]}\007"
     exec ssh "$@"
  )
  reset
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
setopt interactive_comments

if type "atuin" > /dev/null; then
  eval "$(atuin init zsh)"
fi

alias hcode="sgpt --code --chat code"
alias haws="sgpt --shell --role aws"
alias haz="sgpt --shell --role az"
alias hgo="sgpt --chat go_code --role go"
alias hpy="sgpt --chat py_code --role py"
alias hsh="sgpt -s"
alias gbsn="git bisect run"

_atuin_up_search() {
    _atuin_search --shell-up-key-binding --filter-mode session
}

_atuin_dir_search() {
    _atuin_search --filter-mode directory
}
zle -N _atuin_dir_search_widget _atuin_dir_search
bindkey '\er' _atuin_dir_search_widget

checkout_wip() {
  git for-each-ref --sort="-authordate:iso8601" --format="[%(authordate:relative)] %(refname:short)" refs/heads | fzf --height 40% --reverse --nth=-1 --preview="git log --color --graph --abbrev-commit --pretty=format:\"%C(auto)%h%Creset%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\" develop..{-1}" --bind "enter:become(git switch {-1})" --prompt "Switch branch: "
}
alias wip=checkout_wip

export AWS_CLI_AUTO_PROMPT=on-partial

t() {
  tmux new-session -A -s "${1:-general}"
}

tm() {
  tmux new-session -t "${1:-general}"
}

zlong_send_notifications=false
zlong_duration=10
zlong_ignore_cmds="vim nvim hx ssh"
