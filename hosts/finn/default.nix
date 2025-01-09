{
  config,
  pkgs,
  unstable,
  vars,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  ### --- Custom options --- ###

  custom.desktops.hyprland.monitorsLayout = [
    "HDMI-A-1,1920x1080@60,0x180,1"
    "DP-1,2560x1440@164.80,1920x0,1"
    "Unknown-1,disable"
  ];

  ### --- Device specific --- ###
  sops.secrets."smb/username" = {};
  sops.secrets."smb/password" = {};

  sops.templates."smb_credentials".content = ''
    username=${config.sops.placeholder."smb/username"}
    password=${config.sops.placeholder."smb/password"}
  '';

  fileSystems."/home/${vars.user}/NAS" = {
    device = "//192.168.1.100/hostyn";
    fsType = "cifs";
    options = let
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      permissions = "uid=1000,gid=1000,dir_mode=0755,file_mode=0755";
    in ["${automount_opts},${permissions},credentials=${config.sops.templates."smb_credentials".path}"];
  };

  fileSystems."/home/${vars.user}/Media" = {
    device = "192.168.1.100:/mnt/nvme/media";
    fsType = "nfs";
  };

  ### --- Hardware specific --- ###
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
      };
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 10;
      };
      grub2-theme = {
        enable = true;
        theme = "stylish";
        screen = "2k";
      };
    };
    tmp = {
      cleanOnBoot = true;
      tmpfsSize = "5GB";
    };
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [vaapiVdpau];
    };
  };

  services.xserver.videoDrivers = ["nvidia"];

  boot.kernelParams = ["nvidia-drm.modeset=1"];

  hardware.nvidia = {
    modesetting.enable = false;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    # package = unstable.linuxKernel.packages.linux_6_6.nvidia_x11;
  };
}
