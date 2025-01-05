{
  inputs,
  config,
  lib,
  vars,
  palette,
  ...
}: let
  cfg = config.custom.desktops.hyprland;
in {
  config = lib.mkIf cfg.enable {
    home-manager.users.${vars.user} = {
      programs.hyprlock = {
        enable = true;
        settings = {
          background = {
            path = "$HOME/.config/wallpapers/car.jpg";
            blur_passes = 3;
            contrast = 0.8916;
            brightness = 0.8172;
            vibrancy = 0.1696;
            vibrancy_darkness = 0.0;
          };

          general = {
            no_fade_in = false;
            grace = 5;
            disable_loading_bar = false;
            hide_cursor = true;
            ignore_empty_password = true;
          };

          input-field = {
            valign = "center";
            halign = "center";
            size = "200, 40";
            dots-center = true;
            position = "0, -64";
            rounding = 5;
            outline_thickness = 0;
            inner_color = "rgba(${inputs.nix-colors.lib.conversions.hexToRGBString ", " palette.base00}, 0.5)";
            font_color = "rgba(${inputs.nix-colors.lib.conversions.hexToRGBString ", " palette.base07}, 0.5)";
            check_color = "rgba(${inputs.nix-colors.lib.conversions.hexToRGBString ", " palette.base0E}, 0.5)";
            fail_color = "rgba(207, 53, 46, 0.5)";
            placeholder_text = "";
          };

          label = [
            # TIME
            {
              text = "cmd[update:1000] date +%H:%M:%S";
              font_size = 64;
              font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
              position = "0, 112";
              halign = "center";
              valign = "center";
            }
            # DATE
            {
              text = "cmd[update:1000] date +\"%A %d de %B de %Y\" | awk '{print toupper(substr($1,1,1)) substr($1,2), $2, $3, toupper(substr($4,1,1)) substr($4,2), $5, $6}'";
              font_size = 18;
              font_family = "JetBrains Mono Nerd Font Mono";
              position = "0, 46";
              halign = "center";
              valign = "center";
            }

            # HI
            {
              text = "Hola 👋, $USER";
              font_size = 16;
              font_family = "JetBrains Mono Nerd Font Mono";
              position = "0, 0";
              halign = "center";
              valign = "center";
            }

            # NOW PLAYING
            {
              text = "cmd[update:1000] echo \"$(playerctl metadata -a --format '{{ status }} {{ title }} - {{ artist }} 󰎇 ' | grep Playing | cut -d' ' -f2- | head -n 1)\"";
              font_size = 12;
              font_family = "JetBrains Mono Nerd Font Mono";
              position = "0, 16";
              halign = "center";
              valign = "bottom";
            }
          ];
        };
      };
    };
  };
}
