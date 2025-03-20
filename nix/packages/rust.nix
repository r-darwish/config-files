{ pkgs, lib, config, ... }:
with lib;
let cfg = config.darwish.rust;
in {
  options.darwish.rust = { enable = mkEnableOption "Rust packages"; };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ rustc rustfmt rust-analyzer clippy ];
  };
}
