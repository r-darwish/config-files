
use std log

def "zellij attach-default" [session: string = "main"] {
    zellij --layout compact attach -c $session
}

def "brew interactive" [query: string] {
    brew search $query | lines | where ($it | is-not-empty) | to text | fzf --preview='HOMEBREW_COLOR=1 brew info {}' | lines | each { |p| brew install -q $p }
}

alias yt-mp3 = yt-dlp -x --audio-format mp3
alias st = starship toggle
alias tidy = go mod tidy
alias copy = kitten clipboard
alias paste = kitten clipboard --get-clipboard
alias zj = zellij attach-default
alias zl = zellij list-sessions
alias bi = brew interactive

use git
alias gcd = git checkout-default
alias gmd = git merge-default
alias gsb = git switch-branch
alias gam = git auto-merge
alias ghr = git hard-reset
alias lg = lazygit
alias gco = git checkout
alias gb = git branch

use docker
