{
  config,
  lib,
  vars,
  ...
}: let
  cfg = config.custom.theming.wallpapers;
in {
  options.custom.theming.wallpapers = {
    enable = lib.mkEnableOption "Enable custom theming";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${vars.user} = {
      home.file.".config/wallpapers" = {
        source = ./wallpapers;
      };
    };
  };
}
