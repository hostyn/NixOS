{
  config,
  lib,
  vars,
  ...
}: let
  cfg = config.custom.shells.scripts;
in {
  options.custom.shells.scripts = {
    powermenu = {
      enable = lib.mkEnableOption "Enable powermenu script";
    };
  };

  config = {
    home-manager.users.${vars.user} = {
      home.file.".config/scripts/powermenu" = lib.mkIf cfg.powermenu.enable {
        source = ./scripts/powermenu;
        executable = true;
      };
    };
  };
}
