autoload -Uz compinit
compinit

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

dark() {
    osascript -e 'tell app "System Events" to tell appearance preferences to set dark mode to not dark mode'
}

e() {
    local dir
    dir=$(readlink -f "$1")

    title "$(basename "$dir")"
    if [[ -d "$dir" ]]; then
        cd "$dir"
        [[ -f "$dir/go.mod" ]] && go mod tidy
        if [[ -f "$dir/pyproject.toml" ]]; then
            PYTHONPATH="$(realpath "$dir")" poetry run "$EDITOR" "$dir"
            return $?
        fi
    fi

    $EDITOR "$dir"
    return $?
}

en() {
    kitty @launch "$EDITOR" "$(realpath "$1")"
}

ed() {
    local dir
    dir=$(zoxide query --interactive -- "$@") || return 1
    e "$dir"
}

yd() {
    local dir
    dir=$(zoxide query --interactive -- "$@") || return 1
    yazi "$dir"
}

git_checkout_default() {
    [[ -n "$(git diff --quiet --cached || git diff --quiet)" ]]
    to_stash=$?

    [[ $to_stash -eq 0 ]] && git stash
    git checkout "$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')"
    git pull --rebase
    [[ $to_stash -eq 0 ]] && git pop
}

git_merge_default() {
    git fetch
    git merge "$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^origin/@@')"
}

alias gcd=git_checkout_default
alias gmd=git_merge_default
alias automerge="gh pr create -f && gh pr merge -s --auto"
alias yt-mp3="yt-dlp -x --audio-format mp3"

compctl -K _es_completion es
compdef _es_completion es

alias ek=edit-in-kitty
alias ks=kubectx
alias lg=lazygit
alias st="starship toggle"
alias c="bat"
alias tidy="go mod tidy"
alias psh="poetry shell"
alias copy="kitten clipboard"
alias paste="kitten clipboard --get-clipboard"
alias fqi="fq -i ."

pe () {
    title "$(basename "$1")"
    poetry run -C "$1" "$EDITOR" "$1"
}

title() {
    echo -ne "\033]0;$1\007"
}

s() {
    (
        # shellcheck disable=SC2145
        title "${@[-1]}"
        if type "kitty" >/dev/null; then
            exec kitty +kitten ssh "$@"
        fi
        exec ssh "$@"
    )
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
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^[[H" beginning-of-line  # Home key
bindkey "^[[F" end-of-line        # End key
export WORDCHARS=${WORDCHARS//[-_\/]/}

autoload -U edit-command-line
zle -N edit-command-line

edit-or-last-command-line() {
    if [ -z "$BUFFER" ]; then
        zle up-line-or-history
    fi
    zle edit-command-line
    zle accept-line
}

zle -N edit-or-last-command-line
bindkey '^v' edit-or-last-command-line

# shellcheck source=zsh/plugins-post.zsh
source "$plugins_dir/plugins-post.zsh"
setopt AUTO_PUSHD
setopt interactive_comments

if type "lsd" >/dev/null; then
    alias ls="lsd --hyperlink=auto"
fi

alias gbsn="git bisect run"
alias gpr="git pull --rebase"
alias gs="git status"
alias gd="git diff"
alias gf="git fetch"
alias gm="git merge"
alias gc="git commit"
alias gca="git commit --amend"
alias gco="git checkout"
alias ga="git add"
alias gp="git push"

grhh() {
    local repo_name
    git status -uno -s

    repo_name=$(git rev-parse --show-toplevel) || return 1
    repo_name=$(basename "$repo_name") || return 1

    printf "\nRepository is \033[0;31m%s\033[0m\n" "$repo_name"
    gum confirm --default=false "Reset changes" && git reset --hard "${1:-HEAD}"
}


checkout_wip() {
    local default_branch
    default_branch=$(git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@') || return 1
    git for-each-ref --sort="-authordate:iso8601" --format="[%(authordate:relative)] %(refname:short)" refs/heads | fzf --height 40% --reverse --nth=-1 --preview="git log --color --graph --abbrev-commit --pretty=format:\"%C(auto)%h%Creset%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\" $default_branch..{-1}" --bind "enter:become(git switch {-1})" --prompt "Switch branch: "
}
alias wip=checkout_wip

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

export FZF_DEFAULT_OPTS="
	--color=fg:#908caa,bg:#232136,hl:#ea9a97
	--color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
	--color=border:#44415a,header:#3e8fb0,gutter:#232136
	--color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

fix-git-completion() {
    (
        set -e
        cd /usr/local/share/zsh/site-functions
        rm _git
        ln -s ../../../Cellar/zsh/*/share/zsh/functions/_git _git
    )
}

load-env() {
    export "$(grep -vE "^(#.*|\s*)$" "$1")"
}

function yz() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias r="source ~/.zshrc"
alias ec="\$EDITOR ~/.zshrc && source ~/.zshrc"

lgf () {
    local git_dir
    git_dir="$(cd "$(dirname "$1")" && git rev-parse --show-toplevel)"
    lg --filter "$(readlink -f "$1")" -p "$git_dir" || return 1
}

mcd () {
    mkdir -p "$1" && cd "$1"
}

repo_dir="$(dirname "$(readlink -f ~/.zshrc)")"
# shellcheck disable=SC1094
source "$repo_dir/gen.zsh"
