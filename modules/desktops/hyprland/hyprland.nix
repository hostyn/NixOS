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
    programs.hyprland.enable = true;
    services.udisks2.enable = true;

    environment.systemPackages = with pkgs; [
      udiskie # Udisks2 tray icon
      playerctl # Media player control
      hyprpicker # Color picker
      wl-clipboard # Clipboard manager - needed for hyprpicker
      grim # Screenshot tool
      slurp # Region selection tool - needed for grim
      hyprpolkitagent # Polkit agent
      wlsunset # Night mode
      networkmanagerapplet # Internet tray icon
    ];

    home-manager.users.${vars.user} = {
      wayland.windowManager.hyprland = {
        enable = true;

        settings = {
          # MONITORS
          monitor = cfg.monitorsLayout;

          env = [
            "QT_QPA_PLATFORM, wayland"
            "QT_QPA_PLATFORMTHEME, qt5ct"
            "QT_STYLE_OVERRIDE,kvantum"
            "WLR_NO_HARDWARE_CURSORS, 1"
            "ELECTRON_OZONE_PLATFORM_HINT, auto"
            "NIXOS_OZONE_WL, 1"
            "LIBVA_DRIVER_NAME, nvidia"
            "__GLX_VENDOR_LIBRARY_NAME, nvidia"
          ];

          # AUTO START
          exec-once = [
            "hyprpaper"
            "waybar"
            "udiskie -t"
            "hyprctl dispatch focusmonitor 1"
            "systemctl --user start hyprpolkitagent"
            "${pkgs.wlsunset}/bin/wlsunset -l 38.353717 -L -0.491745 -t 5000"
            "nm-applet"
            "${pkgs.syncthingtray}/bin/syncthingtray --wait"
            "[workspace 1 silent] ${pkgs.brave}/bin/brave --password-store=gnome-libsecret"
          ];

          # KEY BINDINGS
          "$mod" = "SUPER";

          bind =
            [
              # WINDOW KEYS
              "$mod, W, killactive"

              # APPLICATION KEYS
              "$mod, RETURN, exec, ${pkgs.kitty}/bin/kitty"
              "$mod, G, exec, ${pkgs.brave}/bin/brave --password-store=gnome-libsecret"
              "$mod, V, exec, ${pkgs.vscode}/bin/code --password-store=gnome-libsecret"
              "$mod, M, exec, pidof ${pkgs.wofi}/bin/wofi || ${pkgs.wofi}/bin/wofi --show drun"

              # ACTION KEYS
              "$mod Alt_L, P, exec, ${pkgs.hyprpicker}/bin/hyprpicker -ar | xargs -I {} dunstify \"Color copied to clipboard\" \"<span background='{}'>{}</span>\""
              ", Print, exec, ${pkgs.grim}/bin/grim -o $(hyprctl activeworkspace -j | jq -r '.monitor') $HOME/Pictures/$(date +\"Screenshot_%Y-%m-%d_%H.%M.%S.%s.png\") && dunstify 'Screnshot saved' 'Saved in ~/Pictures'"
              "Ctrl_L, Print, exec, ${pkgs.grim}/bin/grim -g \"$(${pkgs.slurp}/bin/slurp)\" $HOME/Pictures/$(date +\"Screenshot_%Y-%m-%d_%H.%M.%S.%s.png\") && dunstify 'Screnshot saved' 'Saved in ~/Pictures'"

              # MEDIA KEYS
              ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
              ", XF86AudioStop, exec, ${pkgs.playerctl}/bin/playerctl -a pause"
              ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
              ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"

              # VOLUME KEYS
              ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
              ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
              ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

              # SESSION KEYS
              "$mod SHIFT, Delete, exec, $HOME/.config/scripts/powermenu"
              "$mod SHIFT, L, exec, loginctl lock-session"

              # WORKSPACE KEYS
              "$mod, E, focusworkspaceoncurrentmonitor, 1"
              "$mod, R, focusworkspaceoncurrentmonitor, 2"
              "$mod, T, focusworkspaceoncurrentmonitor, 3"
              "$mod, Y, focusworkspaceoncurrentmonitor, 4"
              "$mod, U, focusworkspaceoncurrentmonitor, 5"
              "$mod, I, focusworkspaceoncurrentmonitor, 6"
              "$mod, O, focusworkspaceoncurrentmonitor, 7"
              "$mod, P, focusworkspaceoncurrentmonitor, 8"

              "$mod SHIFT, E, movetoworkspace, 1"
              "$mod SHIFT, R, movetoworkspace, 2"
              "$mod SHIFT, T, movetoworkspace, 3"
              "$mod SHIFT, Y, movetoworkspace, 4"
              "$mod SHIFT, U, movetoworkspace, 5"
              "$mod SHIFT, I, movetoworkspace, 6"
              "$mod SHIFT, O, movetoworkspace, 7"
              "$mod SHIFT, P, movetoworkspace, 8"

              # WORKPACE MOVEMENT KEYS
              "$mod, h, movefocus, l"
              "$mod, l, movefocus, r"
              "$mod, k, movefocus, u"
              "$mod, j, movefocus, d"

              # MONITOR KEYS
              "$mod, comma, focusmonitor, 0"
              "$mod, period, focusmonitor, 1"

              "$mod, F, togglefloating,"
            ]
            ++ (
              if lib.elem pkgs.brightnessctl config.environment.systemPackages
              then [
                # BRIGHTNESS KEYS - TODO: Make this a custom option
                ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
                ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
              ]
              else []
            );

          bindm = [
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
          ];

          windowrulev2 = [
            "float, class:(feh)"
            "float, class:(ark)"
            "float, class:(org.kde.polkit-kde-authentication-agent-1)"
            "workspace 3, class:(code)"
            "workspace 1, class:(brave-browser)"
            "workspace 8, class:(feishin)"
            "pin, title:(_crx_)(.*)"
            "float, title:(_crx_)(.*)"
            "move onscreen cursor -50% -50%, title:(_crx_)(.*)"
            "move onscreen cursor -50% -50%, class:(code),floating:1"
          ];

          workspace = [
            "1, monitor:DP-1, default:true"
            "2, monitor:HDMI-A-1, default:true"
          ];

          general = {
            gaps_in = 5;
            gaps_out = 15;

            border_size = 2;
            "col.active_border" = "rgb(${palette.base0D})";
          };

          # KEYBOARD LAYOUT
          input = {
            kb_layout = "es";
            follow_mouse = 1;
            sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

            touchpad = {
              natural_scroll = true;
            };
          };

          decoration = {
            rounding = 10;

            # Change transparency of focused and unfocused windows
            active_opacity = 1.0;
            inactive_opacity = 1.0;

            shadow = {
              enabled = true;
              range = 4;
              render_power = 3;
            };

            blur = {
              enabled = true;
              new_optimizations = true;

              size = 3;
              passes = 1;
              vibrancy = 0.1696;
            };
          };

          misc = {
            disable_hyprland_logo = true;
          };
        };
      };
    };
  };
}
