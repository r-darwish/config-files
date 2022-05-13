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

if type "starship" > /dev/null; then
  eval "$(starship init zsh)"
else
  zplug "themes/refined", from:oh-my-zsh 
fi

alias ks=kubectx
alias choco="sudo.exe choco"
alias l="exa -l --git"
alias ls='ls --color=auto'

zplug load
