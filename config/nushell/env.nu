# Nushell Environment Config File
#
# version = "0.97.1"

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
    ($nu.data-dir | path join 'completions') # default home for nushell completions
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

source ($nu.home-path | path join '.gen.nu')

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
# use std "path add"
# $env.PATH = ($env.PATH | split row (char esep))
# path add /some/path
# path add ($env.CARGO_HOME | path join "bin")
# path add ($env.HOME | path join ".local" "bin")
# $env.PATH = ($env.PATH | uniq)

# To load from a custom file you can use:
# source ($nu.default-config-dir | path join 'custom.nu')

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
