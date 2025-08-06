function gcd -d "Checkout the default git branch"
    set -l diff_cached $(git diff --cached)
    set -l diff $(git diff)
    if test -n "$diff"
        or test -n "$diff_cached"
        git stash
    end

    git checkout $(git_default_branch)
    git pull --rebase

    if test -n "$diff"
        or test -n "$diff_cached"
        git stash pop --quiet
    end
end
