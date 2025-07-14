#!/usr/bin/env nu

def exists [path: string] : any -> bool {
    return (which $path | is-not-empty)
}

def main [] {
    let plugin_path = $nu.current-exe | path dirname | path join "nu_plugin_formats"

    if (exists $plugin_path) {
        plugin add $plugin_path
    }

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

    const local = ([$nu.home-path, ".local.nu"] | path join)
    if ($local | path exists) {
        $"source ($local)\n" | save -a $gen
    }

    const wiz_config = ([$nu.home-path, "wiz-sec", "darwish"] | path join)
    if ($wiz_config | path exists) {
        $"source ([$wiz_config, "wiz.nu"] | path join)\n" | save -a $gen
    }

    let zellij_config = ([$env.FILE_PWD, "config", "zellij"] | path join)
    $"$env.ZELLIJ_CONFIG_DIR = \"($zellij_config)\"\n" | save -a $gen

    if (exists "vivid")  {
        $"$env.LS_COLORS = \"(vivid generate tokyonight-night)\"\n" | save -a $gen
    }
}
