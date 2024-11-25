{
  config,
  lib,
  vars,
  ...
}: let
  cfg = config.custom.programs.alacritty;
in {
  options.custom.programs.alacritty = {
    enable = lib.mkEnableOption "Alacritty terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${vars.user} = {
      programs = {
        alacritty = {
          enable = true;
          settings = {
            colors = {
              bright = {
                black = "#767676";
                blue = "#1a8fff";
                cyan = "#14ffff";
                green = "#23fd00";
                magenta = "#fd28ff";
                red = "#f2201f";
                white = "#ffffff";
                yellow = "#fffd00";
              };
              normal = {
                black = "#000000";
                blue = "#0d73cc";
                cyan = "#0dcdcd";
                green = "#19cb00";
                magenta = "#cb1ed1";
                red = "#cc0403";
                white = "#dddddd";
                yellow = "#cecb00";
              };
              primary = {
                background = "#000000";
                foreground = "#dddddd";
              };
            };

            font = {
              normal.family = "mononoki Nerd Font";
              bold = {style = "Bold";};
              italic = {style = "Italic";};
              size = 14;
              offset = {
                x = 0;
                y = 0;
              };
            };

            window = {
              opacity = 0.5;
              padding = {
                x = 10;
                y = 10;
              };
            };

            cursor = {
              style = {
                shape = "Beam";
                blinking = "Always";
              };
              blink_interval = 500;
              unfocused_hollow = true;
              thickness = 0.15;
            };
          };
        };
      };
    };
  };
}
