{ pkgs, lib, config, ... }:
with lib;
let cfg = config.darwish.python;
in {
  options.darwish.python = { enable = mkEnableOption "Python packages"; };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ pyright python3 ruff uv ]; };
}
