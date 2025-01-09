{
  vars,
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.custom.services.syncthing;
in {
  options.custom.services.syncthing = {
    enable = lib.mkEnableOption "Enable Syncthing service";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      syncthingtray
    ];

    home-manager.users.${vars.user} = {
      services.syncthing = {
        enable = true;
      };
    };
  };
}
