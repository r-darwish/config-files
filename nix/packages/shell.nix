{ pkgs, ... }: {
  home.packages = with pkgs; [
    atuin
    bash-language-server
    carapace
    nushell
    shfmt
    starship
    zoxide
  ];
}
