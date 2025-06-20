
use std log

def "brew interactive" [query: string] {
    brew search $query | lines | where ($it | is-not-empty) | to text | fzf --preview='HOMEBREW_COLOR=1 brew info {}' | lines | each { |p| brew install -q $p }
}

def "skopeo cp" [dest: string] {
    for record in ($in | str replace "/" "!" | split column "!" registry image) {
        skopeo copy -a $"docker://($record.registry)/($record.image)" $"docker://($dest)/($record.image)"
    }
}

def "ez" [query: string = ""] {
    let dir = (zoxide query -i $query)
    cd $dir
    nvim (fzf)
}

def "ef" [] {
    nvim (fzf)
}

def "es" [query: string = ""] {
    cd ~/src
    nvim (fzf)
}

def "ew" [query: string] {
    let bin = (which $query | get 0.path)
    nvim $bin
}

def "from env" []: string -> record {
  lines
    | split column '#' # remove comments
    | get column1
    | parse "{key}={value}"
    | str trim value -c '"' # unquote values
    | transpose -r -d
}

def "e" [file: string] {
    let nvim = ($env | get -i nvim)
    let zellij = ($env | get -i ZELLIJ)

    if $zellij != null {
        zellij edit ($file | path expand)
    } else if $nvim == null {
        nvim $file
    } else {
        nvim --server $nvim --remote-tab ($file | path expand)
    }
}

def "ncd" [] {
    let nvim = $env | get -i nvim
    nvim --server $nvim --remote-send ("<C-\\><C-N>:set noautochdir<CR>:cd " + (pwd | path expand) + "<CR>")
}

def "pacman fix" [] {
    sudo pacman -Sy --needed archlinux-keyring ; sudo pacman -Su
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

def nvd [file: string] {
    let sock = [$nu.home-path, ".local/share/nvim/neovide.sock"] | path join
    if ($sock | path exists) {
        nvim --server $sock --remote ($file | path expand)
    } else {
        neovide $file
    }
}

def --env y [...args] {
    let tmp = (mktemp -t "yazi-cwd.XXXXXX")
    yazi ...$args --cwd-file $tmp
    let cwd = (open $tmp)
    if $cwd != "" and $cwd != $env.PWD {
        cd $cwd
    }
    rm -fp $tmp
}

def godbg [...args] {
    dlv debug --headless -l 127.0.0.1:31337 --accept-multiclient ...$args
}

def lgl [path: string] {
    lazygit log --filter ($path | path expand)
}

def v [file: string] {
    let nvim_sock = ($env | get "NVIM")
    if ($nvim_sock | is-not-empty) {
        nvim --server $nvim_sock --remote ($file | path expand)
    } else {
        nvim $file
    }
}

alias vd = edit dir
alias yt-mp3 = yt-dlp -x --audio-format mp3
alias st = starship toggle
alias tidy = go mod tidy
alias copy = kitten clipboard
alias paste = kitten clipboard --get-clipboard
alias zj = zellij
alias za = zellij attach -c
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
alias gpr = git pull --rebase --autostash
alias ga = git add
alias gst = git status
alias gc = git commit
alias gf = git fetch
alias gd = gh dash
alias ur = uv run
alias sc = sudo systemctl
alias sce = sudo systemctl enable --now
alias scs = systemctl status

$env.HOMEBREW_NO_AUTO_UPDATE = "1"
