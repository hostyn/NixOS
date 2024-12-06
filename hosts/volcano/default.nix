{vars, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  ### --- Custom options --- ###
  custom.services.k3s.enable = false;
  custom.programs.nh.enable = true;
  custom.shells.git.enable = true;
  custom.programs.codium.enable = true;
  custom.shells.zsh.enable = true;

  ### --- Device specific --- ###

  services.code-server.enable = true;
  services.code-server.auth = "none";
  services.code-server.user = vars.user;
  services.code-server.port = 4444;

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [4444];
  networking.firewall.allowedUDPPorts = [4444];

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
  };

  ### --- Hardware specific --- ###
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = vars.hostname;

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Madrid";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "es_ES.UTF-8";
  };

  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };

  console.keyMap = "es";
}
