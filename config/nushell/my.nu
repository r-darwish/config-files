
use std log

def "git default-branch" [] {
    git symbolic-ref refs/remotes/origin/HEAD | str replace 'refs/remotes/origin/' ''
}

def "git checkout-default" [] {
    let diff_cached = (git diff --cached | complete | get stdout)
    let diff = (git diff | complete | get stdout)
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

alias gcd = git checkout-default
alias gmd = git merge-default
alias gam = gh automerge
alias yt-mp3 = yt-dlp -x --audio-format mp3
alias lg = lazygit
alias st = starship toggle
alias tidy = go mod tidy
alias copy = kitten clipboard
alias paste = kitten clipboard --get-clipboard
