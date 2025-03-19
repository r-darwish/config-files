{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.darwish.kubernetes;
  pkgsUnstable = import <nixpkgs-unstable> { };
in {
  options.darwish.kubernetes = {
    enable = mkEnableOption "Kubernetes packages";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      kubectl
      k9s
      helm
      helmfile
      pkgsUnstable.mirrord
    ];
  };
}
