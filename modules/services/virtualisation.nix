{
  config,
  lib,
  vars,
  ...
}: let
  cfg = config.custom.services.virtualisation;
in {
  options.custom.services.virtualisation = {
    enable = lib.mkEnableOption "Enable virtualisation services";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    virtualisation.docker.enable = true;
    programs.virt-manager.enable = true;

    users.users.${vars.user} = {
      isNormalUser = true;
      extraGroups = ["libvirtd"];
    };

    home-manager.users.${vars.user} = {
      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
        };
      };
    };
  };
}
