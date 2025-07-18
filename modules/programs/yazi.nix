{
  config,
  lib,
  vars,
  ...
}: let
  cfg = config.custom.programs.yazi;
in {
  options.custom.programs.yazi = {
    enable = lib.mkEnableOption "Yazi";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${vars.user} = {
      programs.yazi = {
        enable = true;
      };
    };
  };
}
