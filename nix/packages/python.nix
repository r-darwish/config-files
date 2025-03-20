{ pkgs, lib, config, ... }:
with lib;
let cfg = config.darwish.python;
in {
  options.darwish.python = { enable = mkEnableOption "Python packages"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      python312Packages.debugpy
      pyright
      python3
      ruff
      uv
    ];
  };
}
