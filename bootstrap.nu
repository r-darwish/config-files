#!/usr/bin/env nu

def exists [path: string] -> bool {
  return (which $path | is-not-empty)
}

def main [] {
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

  const wiz_config = ([$nu.home-path, "wiz-sec", "darwish"] | path join)
  if ($wiz_config | path exists) {
      $"source ([$wiz_config, "wiz.nu"] | path join)" | save -a $gen
  }

  if (open /etc/shells | lines | where  $it == $nu.current-exe | is-empty) {
    echo $nu.current-exe | sudo tee -a /etc/shells
  }

  if $env.SHELL != $nu.current-exe {
    sudo chsh -s $nu.current-exe (whoami)
  }
}
