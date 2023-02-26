autoload -Uz compinit
compinit
for f in $(dirname "$(realpath ~/.zshrc)")/zsh/*.zsh; do
  source $f
done


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

dirs=("/home/linuxbrew/.linuxbrew/bin" "${HOME}/.local/bin")

for dir in $dirs; do
  if [[ -d "$dir" ]] && [[ ":$PATH:" != *":$dir:"* ]]; then
    export PATH="$dir:$PATH"
  fi
done

bindkey -e
