{
  config,
  lib,
  ...
}: let
  cfg = config.custom.programs.steam;
in {
  options.custom.programs.steam = {
    enable = lib.mkEnableOption "steam";
  };

  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
    };
  };
}
