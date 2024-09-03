
use std log

def "git default-branch" [] {
    git symbolic-ref refs/remotes/origin/HEAD | str replace 'refs/remotes/origin/' ''
}

def "git checkout-default" [] {
    let diff_cached: string = (git diff --cached | complete | get stdout)
    let diff: string = (git diff | complete | get stdout)
    let dirty = ($diff_cached | is-not-empty) or ($diff | is-not-empty)
    if $dirty {
        git stash
    }

    git checkout (git default-branch)
    git pull --rebase

    if $dirty {
        git stash pop --quiet
    }
}

def "git merge-default" [] {
    git fetch
    git merge (git default-branch)
}

def "gh automerge" [] {
    gh pr create -f
    gh pr merge -s --auto
}

def "git hard-reset" [target: string = "HEAD"] {
    git status -uno -s
    let repo_name: string = (git rev-parse --show-toplevel | path basename)
    print $"Repository is (ansi red)($repo_name)(ansi reset)"
    gum confirm --default=false "Reset changes"
    git reset --hard $target
}

alias gcd = git checkout-default
alias gmd = git merge-default
alias gam = gh automerge
alias ghr = git hard-reset
alias yt-mp3 = yt-dlp -x --audio-format mp3
alias lg = lazygit
alias st = starship toggle
alias tidy = go mod tidy
alias copy = kitten clipboard
alias paste = kitten clipboard --get-clipboard
alias gs = git status
alias gd = git diff
alias gf = git fetch
alias gm = git merge
alias gc = git commit
alias gco = git checkout
alias ga = git add
alias gp = git push
