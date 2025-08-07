set fish_greeting

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

function es -d "Edit a file in the source directory"
    cd ~/src
    nvim $(fd |fzf)
end

function godbg -d "Debug go"
    dlv debug --headless -l 127.0.0.1:31337 $argv
end

alias ls="lsd -l"
alias yt-mp3="yt-dlp -x --audio-format mp3 --no-playlist"
alias st="starship toggle"
alias tidy="go mod tidy"
alias zj="zellij"
alias za="zellij attach -c"
alias gm="git merge"
alias lg="lazygit"
alias zlg="zellij run -f -- lazygit"
alias gco="git checkout"
alias gb="git branch"
alias gp="git push"
alias gpr="git pull --rebase --autostash"
alias ga="git add"
alias gst="git status"
alias gc="git commit"
alias gf="git fetch"
alias ur="uv run"
alias sc="sudo systemctl"
alias sce="sudo systemctl enable --now"
alias scs="systemctl status"

# TokyoNight Color Palette
set -l foreground c0caf5
set -l selection 283457
set -l comment 565f89
set -l red f7768e
set -l orange ff9e64
set -l yellow e0af68
set -l green 9ece6a
set -l purple 9d7cd8
set -l cyan 7dcfff
set -l pink bb9af7

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_option $pink
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection

test -e ~/.gen.fish && source ~/.gen.fish

fish_add_path --path ~/.local/bin
