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
      hyprpaper
    ];

    home-manager.users.${vars.user} = {
      services.hyprpaper = {
        enable = true;
        settings = {
          preload = ["$HOME/.config/wallpapers/island.jpg"];
          wallpaper = ",$HOME/.config/wallpapers/island.jpg";
        };
      };
    };
  };
}
