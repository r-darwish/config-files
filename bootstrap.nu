#!/usr/bin/env nu

def exists [path: string] -> bool {
    return (which $path | is-not-empty)
}

def main [] {
    $nu.current-exe | path dirname | path join "nu_plugin_formats" | plugin add $in

    let gen = $nu.home-path | path join ".gen.nu"
    "" | save -f $gen

    if (exists "starship")  {
        starship init nu | save -a $gen
    }

    if (exists "zoxide")  {
        zoxide init nushell | save -a $gen
    }

    if (exists "atuin")  {
        atuin init nu | save -a $gen
    }

    if (exists "carapace")  {
        mkdir ~/.cache/carapace
        carapace _carapace nushell | save -a $gen
    }

    const local = ([$nu.home-path, ".local.nu"] | path join)
    if ($local | path exists) {
        $"source ($local)" | save -a $gen
    }

    const wiz_config = ([$nu.home-path, "wiz-sec", "darwish"] | path join)
    if ($wiz_config | path exists) {
        $"source ([$wiz_config, "wiz.nu"] | path join)" | save -a $gen
    }

    let nuexec = (which nu | get 0.path)
    if (open /etc/shells | lines | where  $it == $nuexec | is-empty) {
        echo ($nuexec + "\n") | sudo tee -a /etc/shells
    }

    if $env.SHELL != $nuexec {
        sudo chsh -s $nuexec (whoami)
    }
}
