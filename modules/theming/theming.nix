{
  config,
  lib,
  pkgs,
  vars,
  ...
}: let
  cfg = config.custom.theming;
in {
  options.custom.theming = {
    enable = lib.mkEnableOption "Enable custom theming";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${vars.user} = {
      home = {
        packages = with pkgs; [
          adwaita-qt6
          adw-gtk3
        ];

        pointerCursor = {
          gtk.enable = true;
          name = "macOS";
          package = pkgs.apple-cursor;
          size = 20;
        };
      };

      gtk = {
        enable = true;
        font.name = "UbuntuMono Nerd Font Medium";
        theme = {
          name = "adw-gtk3-dark";
        };
        cursorTheme = {
          name = "macOS";
          package = pkgs.apple-cursor;
        };
        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };
      };

      qt = {
        enable = true;
        platformTheme.name = "kde";
      };
    };
  };
}
