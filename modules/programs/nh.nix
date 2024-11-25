{
  config,
  lib,
  vars,
  ...
}: let
  cfg = config.custom.programs.nh;
in {
  options.custom.programs.nh = {
    enable = lib.mkEnableOption "Enable Nix Helper";
  };

  config = lib.mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/${vars.user}/NixOS";
    };
  };
}
