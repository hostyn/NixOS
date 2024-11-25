{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/fb1ab09f-554c-4556-8106-73e62a7b92a1";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-7593e3c9-7956-43e4-a399-696c5bc66417".device = "/dev/disk/by-uuid/7593e3c9-7956-43e4-a399-696c5bc66417";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/64E7-81B9";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
