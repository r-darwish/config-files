
use std log

def "zellij attach-default" [session: string = "main"] {
    zellij --layout compact attach -c $session
}

def "brew interactive" [query: string] {
    brew search $query | lines | where ($it | is-not-empty) | to text | fzf --preview='HOMEBREW_COLOR=1 brew info {}' | lines | each { |p| brew install -q $p }
}

def "skopeo cp" [dest: string] {
    for record in ($in | str replace "/" "!" | split column "!" registry image) {
        skopeo copy -a $"docker://($record.registry)/($record.image)" $"docker://($dest)/($record.image)"
    }
}

def "from env" []: string -> record {
  lines
    | split column '#' # remove comments
    | get column1
    | parse "{key}={value}"
    | str trim value -c '"' # unquote values
    | transpose -r -d
}

alias yt-mp3 = yt-dlp -x --audio-format mp3
alias st = starship toggle
alias tidy = go mod tidy
alias copy = kitten clipboard
alias paste = kitten clipboard --get-clipboard
alias zj = zellij attach-default
alias zl = zellij list-sessions
alias bi = brew interactive
alias kssh = kitty +kitten ssh

use git
use kubectl
alias gcd = git checkout-default
alias gm = git merge
alias gmd = git merge-default
alias gsb = git switch-branch
alias gam = git auto-merge
alias ghr = git hard-reset
alias lg = lazygit
alias gco = git checkout
alias gb = git branch
alias gp = git push
alias gpr = git pull --rebase
alias ga = git add
alias gst = git status
alias gc = git commit
alias gf = git fetch

use docker
