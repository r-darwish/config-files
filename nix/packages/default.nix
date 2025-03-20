{ pkgs, ... }: {
  imports = [
    ./cloud.nix
    ./go.nix
    ./kubernetes.nix
    ./python.nix
    ./rust.nix
    ./shell.nix
    ./zig.nix
  ];

  home.packages = with pkgs; [
    dua
    fastfetch
    fd
    fzf
    gcc
    gh
    git
    gnumake
    go-task
    htop
    jq
    lazygit
    lua-language-server
    neovim
    nil
    nix-tree
    nixfmt-classic
    nodejs
    ripgrep
    stylua
    tmux
    yazi
  ];
}
