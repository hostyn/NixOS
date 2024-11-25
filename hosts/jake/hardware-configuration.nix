{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/ffe15dd3-be83-40af-8082-e2206a64ec39";
    fsType = "ext4";
  };

  boot.initrd.luks.devices."luks-e830c8c2-97fb-4fc0-9cb6-197bf802f47a".device = "/dev/disk/by-uuid/e830c8c2-97fb-4fc0-9cb6-197bf802f47a";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/6E86-9EF5";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
