
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

def "edit dir" [query?: string] {
    let dir = zoxide query -i ($query | default "") | str trim
    cd $dir
    nvim
}

def "edit exec" [exec: string] {
    let path = which $exec | get 0.path
    nvim $path
}

def "vj" [] {
    let f = (mktemp --suffix ".json")
    $in | jq | save -f $f
    nvim $f
    rm $f
}

def _wez_pane [] {
    wezterm cli list --format json | from json | each {|| {value: $in.pane_id, description: $in.title} }
}

def _wez_direction [] {
    ["left", "right", "top", "bottom"]
}

def "wezmove" [src: string@_wez_pane, dest: string@_wez_pane, --direction (-d): string@_wez_direction = "right"] {
    wezterm cli split-pane --move-pane-id $src --pane-id $dest $"--($direction)"
}

alias v = nvim
alias vd = edit dir
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

$env.HOMEBREW_NO_AUTO_UPDATE = "1"

use docker
