{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.darwish.zig;
  pkgsUnstable = import <nixpkgs-unstable> { };
in {
  options.darwish.zig = { enable = mkEnableOption "Zig packages"; };

  config =
    mkIf cfg.enable { home.packages = with pkgs; [ pkgsUnstable.zig zls ]; };
}
