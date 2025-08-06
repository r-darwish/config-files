function git_default_branch -d "Get the default git branch"
    string replace refs/remotes/origin/ '' $(git symbolic-ref refs/remotes/origin/HEAD)
end
