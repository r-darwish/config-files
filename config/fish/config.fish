set fish_greeting

set linuxbrew_dir /home/linuxbrew/
set lima_docker $HOME/.lima/docker/sock/docker.sock

test -e $lima_docker && set -gx DOCKER_HOST "unix://$lima_docker"

set ssh_sock_symlink ~/.ssh-auth.sock
if set -q SSH_AUTH_SOCK
    and test $SSH_AUTH_SOCK != $ssh_sock_symlink
    ln -fs $SSH_AUTH_SOCK $ssh_sock_symlink
    export SSH_AUTH_SOCK=$ssh_sock_symlink
end

function add_to_path
    test -d $argv[1] && fish_add_path --path $argv[1]
end

add_to_path /home/linuxbrew/.linuxbrew/bin
add_to_path ~/.local/share/nvim/mason/bin

function bi -d "Install a brew package"
    brew search $query | fzf --preview='HOMEBREW_COLOR=1 brew info {}' | xargs brew install -q
end

function cdf -d "Interactive cd"
    cd $(fd --type d | fzf)
end

function ez -d "Edit a file a zoxide saved directory"
    cd $(zoxide query -i)
    nvim $(fd |fzf)
end

function ef -d "Edit a file in the current directory"
    nvim $(fd |fzf)
end

function es -d "Edit a file in the source directory"
    cd ~/src
    nvim $(fd |fzf)
end

function ag -d "Ask auggie for help"
    auggie --print $argv[1] >~/auggie.md
    nvim ~/auggie.md
end

alias ls="lsd -l"
alias yt-mp3="yt-dlp -x --audio-format mp3 --no-playlist"
alias st="starship toggle"
alias zj="zellij"
alias za="zellij attach -c"
alias ze="zellij edit"
alias zlg="zellij run -f -- lazygit"
alias zr="zellij run -f"
alias zri="zellij run -i"
alias ur="uv run"
alias sc="sudo systemctl"
alias sce="sudo systemctl enable --now"
alias scs="systemctl status"

test -e ~/.gen.fish && source ~/.gen.fish

export EDITOR=nvim

fish_add_path --path ~/.local/bin
