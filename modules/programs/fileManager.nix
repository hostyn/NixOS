{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.custom.programs.fileManager;
in {
  options.custom.programs.fileManager = {
    enable = lib.mkEnableOption "Alacritty file manager";
  };

  config = lib.mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        xfce.thunar # Thunar

        libheif # HEIF thumbnailer
        libheif.out
      ];

      pathsToLink = ["share/thumbnailers"]; # Requiered for libheif to work
    };

    services.tumbler.enable = true; # Thumbnailer service
  };
}
