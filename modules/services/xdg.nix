{
  vars,
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.custom.services.xdg;
in {
  options.custom.services.xdg = {
    enable = lib.mkEnableOption "Enable xdg configuration";
  };

  config = lib.mkIf cfg.enable {
    xdg.portal.extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      # pkgs.xdg-desktop-portal-kde
      pkgs.xdg-desktop-portal
    ];

    home-manager.users.${vars.user} = {
      xdg = {
        mime.enable = true;
        mimeApps = {
          enable = true;
          defaultApplications = {
            "image/jpeg" = ["feh.desktop"];
            "image/png" = ["feh.desktop"];
            "text/plain" = "codium.desktop";
            "text/html" = "codium.desktop";
            "text/csv" = "codium.desktop";
            "application/pdf" = ["brave-browser.desktop" "firefox.desktop"];
            "application/zip" = "org.kde.ark.desktop";
            "application/x-tar" = "org.kde.ark.desktop";
            "application/x-bzip2" = "org.kde.ark.desktop";
            "application/x-gzip" = "org.kde.ark.desktop";
            "x-scheme-handler/http" = ["brave-browser.desktop" "firefox.desktop"];
            "x-scheme-handler/https" = ["brave-browser.desktop" "firefox.desktop"];
            "x-scheme-handler/about" = ["brave-browser.desktop" "firefox.desktop"];
            "x-scheme-handler/unknown" = ["brave-browser.desktop" "firefox.desktop"];
            # "x-scheme-handler/mailto" = [ "gmail.desktop" ];org.kde.ark.desktop
            "audio/mp3" = "vlc.desktop";
            "audio/x-matroska" = "vlc.desktop";
            "video/webm" = "vlc.desktop";
            "video/mp4" = "vlc.desktop";
            "video/x-matroska" = "vlc.desktop";
            "inode/directory" = "pcmanfm.desktop";
          };
        };

        desktopEntries = {
          feh = lib.mkIf (lib.elem pkgs.feh config.environment.systemPackages) {
            name = "Feh";
            genericName = "Image viewer";
            comment = "Image viewer and cataloguer";
            exec = "${pkgs.feh}/bin/feh -Z -. -g 1280x720 --start-at %u";
            terminal = false;
            type = "Application";
            icon = "feh";
            categories = ["Graphics" "2DGraphics" "Viewer"];
            mimeType = ["image/bmp" "image/gif" "image/jpeg" "image/jpg" "image/pjpeg" "image/png" "image/tiff" "image/webp" "image/x-bmp" "image/x-pcx" "image/x-png" "image/x-portable-anymap" "image/x-portable-bitmap" "image/x-portable-graymap" "image/x-portable-pixmap" "image/x-tga" "image/x-xbitmap" "image/heic"];
            noDisplay = true;
          };

          codium = lib.mkIf (lib.elem pkgs.vscodium config.environment.systemPackages) {
            categories = ["Utility" "TextEditor" "Development" "IDE"];
            comment = "Code Editing. Redefined.";
            exec = "${pkgs.vscodium}/bin/codium --password-store=gnome-libsecret %F";
            genericName = "Text Editor";
            icon = "vscodium";
            mimeType = ["text/plain" "inode/directory"];
            name = "VSCodium";
            type = "Application";
            settings = {
              Keywords = "vscode";
              StartupWMClass = "vscodium";
              Version = "1.4";
              StartupNotify = "true";
            };
          };

          code = lib.mkIf (lib.elem pkgs.vscode config.environment.systemPackages) {
            categories = ["Utility" "TextEditor" "Development" "IDE"];
            comment = "Code Editing. Redefined.";
            exec = "${pkgs.vscode}/bin/code --password-store=gnome-libsecret %F";
            genericName = "Text Editor";
            icon = "vscode";
            mimeType = ["text/plain" "inode/directory"];
            name = "VSCode";
            type = "Application";
            settings = {
              Keywords = "vscode";
              StartupWMClass = "vscode";
              Version = "1.4";
              StartupNotify = "true";
            };
          };

          brave-browser = lib.mkIf (lib.elem pkgs.brave config.environment.systemPackages) {
            name = "Brave Web Browser";
            genericName = "Web Browser";
            comment = "Access the Internet";
            exec = "${pkgs.brave}/bin/brave --password-store=gnome-libsecret %U";
            terminal = false;
            icon = "brave-browser";
            type = "Application";
            categories = ["Network" "WebBrowser"];
            mimeType = ["application/pdf" "application/rdf+xml" "application/rss+xml" "application/xhtml+xml" "application/xhtml_xml" "application/xml" "image/gif" "image/jpeg" "image/png" "image/webp" "text/html" "text/xml" "x-scheme-handler/http" "x-scheme-handler/https" "x-scheme-handler/ipfs" "x-scheme-handler/ipns"];
            settings = {
              Version = "1.0";
              StartupNotify = "true";
            };
          };
        };
      };
    };
  };
}
