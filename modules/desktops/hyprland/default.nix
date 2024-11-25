{lib, ...}: {
  imports = [
    ./hyprland.nix
    ./hyprpaper.nix
    ./waybar.nix
    ./hyprlock.nix
    ./hypridle.nix
  ];

  options.custom.desktops.hyprland = {
    enable = lib.mkEnableOption "Enable Hyprland desktop";
    monitorsLayout = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [", preferred, auto, 1"];
      example = [", preferred, auto, 1"];
      description = lib.mdDoc "Set monitors layout in hyprland";
    };
  };
}
