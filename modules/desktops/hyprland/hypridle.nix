{
  config,
  lib,
  pkgs,
  vars,
  ...
}: let
  cfg = config.custom.desktops.hyprland;
in {
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      hypridle
    ];

    home-manager.users.${vars.user} = {
      services.hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = "pidof hyprlock || hyprlock";
            before_sleep_cmd = "loginctl lock-session";
            after_sleep_cmd = "hyprctl dispatch dpms on";
          };

          listener = [
            {
              timeout = 3600;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }

            {
              timeout = 1800;
              on-timeout = "loginctl lock-session";
            }
          ];
        };
      };
    };
  };
}
