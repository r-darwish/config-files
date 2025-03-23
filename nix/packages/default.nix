{ pkgs, ... }: {
  imports = [
    ./cloud.nix
    ./go.nix
    ./grpc.nix
    ./kubernetes.nix
    ./python.nix
    ./rust.nix
    ./shell.nix
    ./zig.nix
  ];

  home.packages = with pkgs; [
    dua
    entr
    fastfetch
    fblog
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
    nixfmt-classic
    nix-tree
    nodejs
    ripgrep
    stylua
    tmux
    yazi
    yt-dlp
  ];
}
