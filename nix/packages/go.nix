{ pkgs, lib, config, ... }:
with lib;
let cfg = config.darwish.go;
in {
  options.darwish.go = { enable = mkEnableOption "Go packages"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ flyway go gopls delve golangci-lint ];
  };
}
