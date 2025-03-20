{ pkgs, lib, config, ... }:
with lib;
let cfg = config.darwish.zig;
in {
  options.darwish.zig = { enable = mkEnableOption "Zig packages"; };

  config = mkIf cfg.enable { home.packages = with pkgs; [ zig zls ]; };
}
