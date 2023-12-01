linuxbrew_dir="/home/linuxbrew/.linuxbrew"
bin_dirs=("/usr/local/opt/coreutils/libexec/gnubin" "$linuxbrew_dir/bin" "${HOME}/.local/bin" "$(dirname "$(readlink -f "$HOME/.zshrc")")/bin")

for dir in "${bin_dirs[@]}"; do
    if [[ -d "$dir" ]] && [[ ":$PATH:" != *":$dir:"* ]]; then
        export PATH="$dir:$PATH"
    fi
done

plugins_dir="$(dirname "$(realpath ~/.zshrc)")/zsh"
wiz_plugins="$plugins_dir/plugins-wiz.zsh"

# shellcheck source=zsh/plugins.zsh
source "$plugins_dir/plugins.zsh"
# shellcheck source=zsh/plugins-wiz.zsh
[ -f "$wiz_plugins" ] && source "$wiz_plugins"

if type "hx" >/dev/null; then
    export EDITOR=hx
else
    export EDITOR=vi
fi

_es_completion() {
    local paths=()
    for d in $(echo "$PATH" | tr ':' ' '); do
        while IFS= read -r line; do # Whitespace-safe EXCEPT newlines
            paths+=("$line")
        done <<<"$(find "$d" -type f -perm +111 -user "$(whoami)" -execdir basename '{}' ';' 2>/dev/null)"
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

git_merge_default() {
    git fetch
    git merge "$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^origin/@@')"
}

alias gcd=git_checkout_default
alias gcdu="gcd && gpr"
alias gmd=git_merge_default

compctl -K _es_completion es
compdef _es_completion es

e() {
    if [[ "$TMUX" ]]; then
        tmux split-window "$EDITOR $*"
    else
        kitten @launch --type window "$EDITOR" "$@"
    fi
}

if type "starship" >/dev/null; then
    eval "$(starship init zsh)"
fi

if type "zoxide" >/dev/null; then
    eval "$(zoxide init zsh)"
fi

alias ks=kubectx
alias lg=lazygit
alias st="starship toggle"
alias c="bat"
alias tidy="go mod tidy"
alias psh="poetry shell"
alias copy="kitten clipboard"
alias paste="kitten clipboard --get-clipboard"
alias fqi="fq -i ."

s() {
    (
        # shellcheck disable=SC2145
        echo -ne "\033]0;📡 ${@[-1]}\007"
        if type "kitty" >/dev/null; then
            exec kitty +kitten ssh "$@"
        fi
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

cdf() {
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
        # shellcheck disable=SC2145
        tmux send-keys "$@ $line" C-m
    done
}

ntfy() {
    curl \
        -H "Title: $1" \
        -d "$2" \
        "ntfy.sh/$NTFY_TOPIC" >/dev/null 2>/dev/null
}

bindkey -e
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^v' edit-command-line

# shellcheck disable=SC2034
[ -d $linuxbrew_dir ] && FZF_BASE=$linuxbrew_dir/opt/fzf
# shellcheck source=zsh/plugins-post.zsh
source "$plugins_dir/plugins-post.zsh"
setopt AUTO_PUSHD
setopt interactive_comments

if type "atuin" >/dev/null; then
    eval "$(atuin init zsh)"
fi

if type "lsd" >/dev/null; then
    alias ls="lsd --hyperlink=auto"
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
    local default_branch
    default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@') || return 1
    git for-each-ref --sort="-authordate:iso8601" --format="[%(authordate:relative)] %(refname:short)" refs/heads | fzf --height 40% --reverse --nth=-1 --preview="git log --color --graph --abbrev-commit --pretty=format:\"%C(auto)%h%Creset%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\" $default_branch..{-1}" --bind "enter:become(git switch {-1})" --prompt "Switch branch: "
}
alias wip=checkout_wip

export AWS_CLI_AUTO_PROMPT=on-partial

zj() {
    zellij --layout compact attach -c "${1:-main}"
}

zl() {
    zellij list-sessions
}

# shellcheck disable=SC2034
zlong_send_notifications=false zlong_duration=10 zlong_ignore_cmds="vim nvim hx ssh kitty"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*:descriptions' format '[%d]'
# shellcheck disable=SC2016
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -1 --color=always $realpath'

fix-git-completion() {
    (
        set -e
        cd /usr/local/share/zsh/site-functions
        rm _git
        ln -s ../../../Cellar/zsh/*/share/zsh/functions/_git _git
    )
}

export DEFAULT_COLOR=cyan
export DEFAULT_MODEL=gpt-4
_sgpt_zsh() {
if [[ -n "$BUFFER" ]]; then
    _sgpt_prev_cmd=$BUFFER
    BUFFER+="⌛"
    zle -I && zle redisplay
    BUFFER=$(sgpt --shell <<< "$_sgpt_prev_cmd")
    zle end-of-line
fi
}
zle -N _sgpt_zsh
bindkey '^h' _sgpt_zsh
