{ pkgs, lib, config, ... }:
with lib;
let cfg = config.darwish.grpc;
in {
  options.darwish.grpc = { enable = mkEnableOption "grpc packages"; };

  config = mkIf cfg.enable { home.packages = with pkgs; [ grpcurl grpcui ]; };
}
