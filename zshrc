source ${ZPLUG_HOME:-~/.zplug}/init.zsh

zplug "zsh-users/zsh-autosuggestions"

zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/fzf",   from:oh-my-zsh
zplug "plugins/z",   from:oh-my-zsh
zplug "plugins/sudo",   from:oh-my-zsh
zplug "plugins/tmux",   from:oh-my-zsh
zplug "plugins/docker",   from:oh-my-zsh
zplug "lib/*", from:oh-my-zsh

if [[ -n $WIZ ]]; then
  zplug "wiz-sec/dotfiles", use:"oh-my-zsh-custom/*"
  zplug "wiz-sec/darwish", as:command, use:"bin/*"
  zplug "wiz-sec/darwish", use:"zsh/*"
fi

local gnubin="/usr/local/opt/coreutils/libexec/gnubin"
test -d $gnubin && path=($gnubin $path)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
if type "nvim" > /dev/null; then
  export EDITOR=nvim
else 
  export EDITOR=vi
fi

function nvim() {
  if [[ "$TMUX" ]]; then
    tmux split-window "nvim $*"
  else
    command nvim "$@"
  fi
}

if type "starship" > /dev/null; then
  eval "$(starship init zsh)"
else
  zplug "themes/refined", from:oh-my-zsh 
fi

alias ks=kubectx
alias choco="sudo.exe choco"
alias l="exa -l --git"
alias ls='ls --color=auto'

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

function nd() {
  curl \
  -H "Title: Process done in $(hostname)" \
  -d "" \
  ntfy.sh/$NTFY_TOPIC
}

zplug load
