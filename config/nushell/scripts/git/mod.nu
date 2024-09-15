export def default-branch [] {
    git symbolic-ref refs/remotes/origin/HEAD | str replace 'refs/remotes/origin/' ''
}

export def checkout-default [] {
    let diff_cached: string = (git diff --cached | complete | get stdout)
    let diff: string = (git diff | complete | get stdout)
    let dirty = ($diff_cached | is-not-empty) or ($diff | is-not-empty)
    if $dirty {
        git stash
    }

    git checkout (default-branch)
    git pull --rebase

    if $dirty {
        git stash pop --quiet
    }
}

export def merge-default [] {
    git fetch
    git merge (default-branch)
}

export def auto-merge [] {
    gh pr create -f
    gh pr merge -s --auto
}

export def hard-reset [target: string = "HEAD"] {
    git status -uno -s
    let repo_name: string = (git rev-parse --show-toplevel | path basename)
    print $"Repository is (ansi red)($repo_name)(ansi reset)"
    gum confirm --default=false "Reset changes"
    git reset --hard $target
}

export def switch-branch [] {
    let preview_command = "git log --color --graph --abbrev-commit --pretty=format:\"%C(auto)%h%Creset%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\" " + (git default-branch) + "..{-1}"

    git for-each-ref --sort="-authordate:iso8601" --format="[%(authordate:relative)] %(refname:short)" refs/heads | fzf --height 40% --reverse --nth=-1 --preview=($preview_command) --bind "enter:become(git switch {-1})" --prompt "Switch branch: "
}