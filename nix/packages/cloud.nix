{ pkgs, lib, config, ... }:
with lib;
let
  cfg = config.darwish.cloud;
  pkgsUnstable = import <nixpkgs-unstable> { };
in {
  options.darwish.cloud = { enable = mkEnableOption "cloud packages"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      awscli2
      azure-cli
      google-cloud-sdk
      pkgsUnstable.pulumi
      pkgsUnstable.mirrord
    ];
  };
}
