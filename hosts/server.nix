{
  config,
  vars,
  lib,
  ...
}: {
  imports =
    import ../modules/desktops
    ++ import ../modules/programs
    ++ import ../modules/services
    ++ import ../modules/theming
    ++ import ../modules/shells;

  ### --- Custom options --- ###
  custom.services.k3s.enable = lib.mkDefault true;

  custom.shells.zsh.enable = true;

  ### --- Other options --- ###
  sops.defaultSopsFile = ../secrets/server.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/${vars.user}/.config/sops/age/keys.txt";

  sops.secrets.hashedPassword.neededForUsers = true;

  users.mutableUsers = false;
  users.users.${vars.user} = {
    isNormalUser = true;
    description = "serveradmin";
    extraGroups = ["networkmanager" "wheel"];
    hashedPasswordFile = config.sops.secrets.hashedPassword.path;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDuGzl7Kmz41kb/nYyVUBLICQoOXWWAibgeqH+RT0YdX ruben@martinezhostyn.com"
    ];
  };

  services.openssh.enable = true;
  services.qemuGuest.enable = true;

  programs.git.enable = true;

  security.sudo.wheelNeedsPassword = false;

  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = ["192.168.1.240" "1.1.1.1"];
  networking.interfaces.ens18.ipv4.addresses = [
    {
      address = vars.ipAddress;
      prefixLength = 16;
    }
  ];

  system.stateVersion = "25.05";

  home-manager.users.${vars.user} = {
    home = {
      stateVersion = "25.05";
    };
    programs = {
      home-manager.enable = true;
    };
  };
}
