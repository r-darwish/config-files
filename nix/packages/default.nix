{ pkgs, ... }: {
  imports = [ ./cloud.nix ./go.nix ./python.nix ./kubernetes.nix ./shell.nix ];

  home.packages = with pkgs; [
    fd
    fzf
    gcc
    gh
    git
    gnumake
    go-task
    jq
    lazygit
    lua-language-server
    neovim
    nil
    nixfmt-classic
    nodejs
    ripgrep
    stylua
    yazi
  ];
}
