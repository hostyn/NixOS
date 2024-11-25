{
  config,
  lib,
  vars,
  pkgs,
  ...
}: let
  cfg = config.custom.programs.obs;
in {
  options.custom.programs.obs = {
    enable = lib.mkEnableOption "obs studio";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${vars.user}.programs.obs-studio = {
      enable = true;
      plugins = [pkgs.obs-studio-plugins.obs-pipewire-audio-capture];
    };
  };
}
