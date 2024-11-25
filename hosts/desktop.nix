{
  config,
  pkgs,
  unstable,
  vars,
  ...
}: {
  imports =
    import ../modules/desktops
    ++ import ../modules/programs
    ++ import ../modules/services
    ++ import ../modules/theming
    ++ import ../modules/shells;

  ### --- Custom options --- ###
  custom.desktops.hyprland.enable = true;

  custom.programs.alacritty.enable = true;
  custom.programs.codium.enable = true;
  custom.programs.kitty.enable = true;
  custom.programs.nh.enable = true;
  custom.programs.obs.enable = true;
  custom.programs.wofi.enable = true;

  custom.services.dunst.enable = true;
  custom.services.syncthing.enable = true;
  custom.services.virtualisation.enable = true;
  custom.services.xdg.enable = true;

  custom.shells.zsh.enable = true;
  custom.shells.git.enable = true;
  custom.shells.scripts.powermenu.enable = true;

  custom.theming.enable = true;
  custom.theming.wallpapers.enable = true;

  ### --- Other options --- ###
  sops.defaultSopsFile = ../secrets/desktop.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/${vars.user}/.config/sops/age/keys.txt";

  sops.secrets.hashedPassword = {
    sopsFile = ../secrets/server.yaml;
    neededForUsers = true;
  };

  users.mutableUsers = false;
  users.users.${vars.user} = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.hashedPassword.path;
    extraGroups = ["wheel" "video" "audio" "camera" "networkmanager" "lp" "scanner" "docker"];
  };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm.enableGnomeKeyring = true;
  programs.seahorse.enable = true;

  networking.hostName = vars.hostname;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Madrid";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  console = {
    keyMap = "es";
  };

  services.xserver.xkb = {
    layout = "es";
    variant = "";
  };

  security = {
    rtkit.enable = true;
    polkit.enable = true;
  };

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = ["Mononoki" "UbuntuMono" "Ubuntu" "JetBrainsMono"];
    })
  ];

  environment = {
    variables = {
      # TODO: Set these variables
      # TERMINAL = "${vars.terminal}";
      # EDITOR = "${vars.editor}";
      # VISUAL = "${vars.visualeditor}";
    };

    systemPackages =
      (with pkgs; [
        alejandra
        brave
        calibre # Ebook manager
        cifs-utils
        discord # Chat
        feh
        firefox
        gparted # Partition manager  TODO: Fix this
        jdk22
        jetbrains.idea-community-bin
        kdePackages.ark
        kubectl # Kubernetes CLI
        libreoffice
        libsForQt5.dolphin # File manager
        moonlight-qt
        nfs-utils
        nixd
        nixpkgs-fmt
        obsidian # Notes
        openlens # Kubernetes dashboard
        pavucontrol
        python3
        remmina
        vlc
        youtube-music
      ])
      ++ (with unstable; [
        ]);
  };

  programs = {
    dconf.enable = true;
    direnv.enable = true;
  };

  hardware.pulseaudio.enable = false;

  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
  };

  system = {
    # autoUpgrade = {
    #   enable = true;
    #   channel = "https://nixos.org/channels/nixos-unstable";
    # };
    stateVersion = "24.05";
  };

  home-manager.users.${vars.user} = {
    home = {
      stateVersion = "24.05";
    };
    programs = {
      home-manager.enable = true;
    };
  };
}