{
  config,
  lib,
  pkgs,
  vars,
  palette,
  ...
}: let
  cfg = config.custom.desktops.hyprland;
in {
  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      waybar
    ];

    home-manager.users.${vars.user} = {
      programs.waybar = {
        enable = true;
        settings = {
          waybar = {
            layer = "top";
            position = "top";
            height = 40;
            margin = "15 15 0 15";

            modules-left = [
              "hyprland/workspaces"
              "hyprland/window"
            ];

            modules-right = [
              "mpris"
              "cpu"
              "memory"
              "network"
              "disk"
              "pulseaudio"
              "tray"
              "clock"
            ];

            mpris = {
              interval = 1;
              format = "{player_icon} {title} - {artist} {status_icon}";
              status-icons = {
                playing = " ";
                paused = " ";
                stopped = " ";
              };
              player-icons = {
                spotify = " ";
                brave = " ";
                default = " ";
              };
            };

            pulseaudio = {
              format = "{icon} {volume}%";
              tooltip-format = "{desc} - {volume}%";
              format-icons = {
                default = [" " " " " "];
              };
              format-muted = "  {volume}%";
              on-click = "pavucontrol";
              scrol-step = 2;
            };

            network = {
              format = "  {bandwidthTotalBytes}";
              interval = 2;
              tooltip-format = "{ifname} - {ipaddr}\n{bandwidthDownBytes} ↓ {bandwidthUpBytes} ↑";
              on-click = "kitty btm";
            };

            disk = {
              format = "  {percentage_used}%";
              on-click = "kitty btm";
            };

            memory = {
              format = "  {percentage}%";
              interval = 2;
              tooltip-format = "{used:0.1f}GiB / {total:0.1f}GiB";
              on-click = "kitty btm";
            };

            cpu = {
              format = "  {usage}%";
              interval = 2;
              on-click = "kitty btm";
            };

            tray = {
              icon-size = 12;
              spacing = 15;
            };

            clock = {
              interval = 2;
              format-alt = "{:%A %d %B %Y}";
              tooltip-format = "{:%A %d %B %Y}";
            };

            "hyprland/workspaces" = {
              all-outputs = true;
              move-to-monitor = true;
              format = "{icon}";
              format-icons = {
                "1" = " ";
                "2" = " ";
                "3" = " ";
                "4" = " ";
                "5" = " ";
                "6" = " ";
                "7" = " ";
                "8" = " ";
              };
              persistent-workspaces = {
                "*" = [1 2 3 4 5 6 7 8];
              };
            };

            "hyprland/window" = {
              interval = 2;
            };
          };
        };

        style = ''
          window#waybar {
            background-color: #${palette.base00};
            border-top: none;
            border-radius: 10px;
          }

          #clock, #tray, #cpu, #memory, #disk, #network, #pulseaudio, #mpris {
            padding-right: 7px;
            padding-left: 7px;
          }

          #mpris {
            color: #${palette.base06};
          }

          #pulseaudio {
            color: #${palette.base0A};
          }

          #network {
            color: #${palette.base08};
          }

          #cpu {
            color: #${palette.base0D};
          }

          #memory {
            color: #${palette.base0E};
          }

          #disk {
            color: #${palette.base09};
          }

          #workspaces button {
            color: #${palette.base07};
          }

          #workspaces button.empty {
            color: #${palette.base03};
          }

          #workspaces button.active {
            color: #${palette.base0D};
          }

          #window {
            padding-left: 10px;
          }
        '';
      };
    };
  };
}
