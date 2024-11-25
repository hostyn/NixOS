{
  vars,
  lib,
  config,
  ...
}: let
  cfg = config.custom.services.syncthing;
in {
  options.custom.services.syncthing = {
    enable = lib.mkEnableOption "Enable Syncthing service";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${vars.user} = {
      services.syncthing = {
        enable = true;
        tray.enable = true;
      };
    };
  };
}
