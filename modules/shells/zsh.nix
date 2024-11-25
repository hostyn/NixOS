{
  config,
  pkgs,
  lib,
  vars,
  ...
}: let
  cfg = config.custom.shells.zsh;
in {
  options.custom.shells.zsh = {
    enable = lib.mkEnableOption "Enable zsh shell";
  };

  config = lib.mkIf cfg.enable {
    users.users.${vars.user} = {
      shell = pkgs.zsh;
    };

    programs.zsh.enable = true;

    environment.systemPackages = with pkgs; [
      age
      bat
      bottom
      broot
      dogdns
      duf
      dust
      eza
      glances
      jq
      killall
      nano
      neovim
      pciutils
      pwgen
      sops
      unzip
      wget
    ];

    home-manager.users.${vars.user}.programs = {
      zsh = {
        enable = true;
        autocd = true;

        syntaxHighlighting.enable = true;
        autosuggestion.enable = true;

        history.expireDuplicatesFirst = true;
        history.ignoreDups = true;
        history.ignoreSpace = true;
        history.share = true;

        shellAliases = {
          cat = "${pkgs.bat}/bin/bat";
          catn = "/usr/bin/env cat";
          code = "${pkgs.vscode}/bin/code --password-store=gnome-libsecret";
          config = "code ~/NixOS";
          df = "${pkgs.duf}/bin/duf";
          dig = "${pkgs.dogdns}/bin/dog";
          du = "${pkgs.dust}/bin/dust -Brn 20";
          htop = "${pkgs.bottom}/bin/btm";
          k = "kubectl";
          l = "${pkgs.eza}/bin/eza -ls name --group-directories-first";
          la = "${pkgs.eza}/bin/eza -las name --group-directories-first";
          lat = "${pkgs.eza}/bin/eza -laTs name --group-directories-first";
          ls = "${pkgs.eza}/bin/eza -ls name --group-directories-first";
          lt = "${pkgs.eza}/bin/eza -lTs name --group-directories-first";
          lta = "${pkgs.eza}/bin/eza -laTs name --group-directories-first";
          ssh = "kitten ssh";
          top = "${pkgs.glances}/bin/galnces";
          tree = "${pkgs.broot}/bin/broot";
          vi = "${pkgs.neovim}/bin/nvim";
        };

        plugins = [
          {
            name = "zsh-sudo";
            file = "plugins/sudo/sudo.plugin.zsh";
            src = pkgs.fetchFromGitHub {
              owner = "ohmyzsh";
              repo = "ohmyzsh";
              rev = "dd4be1b6fb9973d63eba334d8bd92b3da30b3e72";
              sha256 = "sha256-d6gqfBxAm4Y1xt204GhPhhEBOwP97K7qCeIf6I6Wbfg=";
            };
          }
        ];

        # TODO: Make initExtra the nix way
        initExtra = "
        bindkey \"^[[H\" beginning-of-line  # Home / Inicio
        bindkey \"^[[F\" end-of-line        # End / Fin
        bindkey \"^[[1;5C\" forward-word    # Ctr + Right
        bindkey \"^[[1;5D\" backward-word   # Ctr + Left
        bindkey \"^[[3~\" delete-char       # Supr
        bindkey \"^H\" backward-delete-word # Ctr + Return

        extract() {
          if [ -f $1 ]; then
            case $1 in
            *.tar.bz2) tar xjf $1 ;;
            *.tar.gz) tar xzf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.rar) rar x $1 ;;
            *.gz) gunzip $1 ;;
            *.tar) tar xf $1 ;;
            *.tbz2) tar xjf $1 ;;
            *.tgz) tar xzf $1 ;;
            *.zip) unzip $1 ;;
            *.Z) uncompress $1 ;;
            *.7z) 7z x $1 ;;
            *) echo \"'$1' cannot be extracted via extract()\" ;;
            esac
          else
            echo \"'$1' is not a valid file\"
          fi
      }";
      };

      starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          aws = {
            symbol = "  ";
          };
          buf = {
            symbol = " ";
          };
          c = {
            symbol = " ";
          };
          conda = {
            symbol = " ";
          };
          crystal = {
            symbol = " ";
          };
          dart = {
            symbol = " ";
          };
          directory = {
            read_only = " 󰌾";
          };
          docker_context = {
            symbol = " ";
          };
          elixir = {
            symbol = " ";
          };
          elm = {
            symbol = " ";
          };
          fennel = {
            symbol = " ";
          };
          fossil_branch = {
            symbol = " ";
          };
          git_branch = {
            symbol = " ";
          };
          golang = {
            symbol = " ";
          };
          guix_shell = {
            symbol = " ";
          };
          haskell = {
            symbol = " ";
          };
          haxe = {
            symbol = " ";
          };
          hg_branch = {
            symbol = " ";
          };
          hostname = {
            ssh_symbol = " ";
          };
          java = {
            symbol = " ";
          };
          julia = {
            symbol = " ";
          };
          kotlin = {
            symbol = " ";
          };
          lua = {
            symbol = " ";
          };
          memory_usage = {
            symbol = "󰍛 ";
          };
          meson = {
            symbol = "󰔷 ";
          };
          nim = {
            symbol = "󰆥 ";
          };
          nix_shell = {
            symbol = " ";
          };
          nodejs = {
            symbol = " ";
          };
          ocaml = {
            symbol = " ";
          };
          os.symbols = {
            Alpaquita = " ";
            Alpine = " ";
            AlmaLinux = " ";
            Amazon = " ";
            Android = " ";
            Arch = " ";
            Artix = " ";
            CentOS = " ";
            Debian = " ";
            DragonFly = " ";
            Emscripten = " ";
            EndeavourOS = " ";
            Fedora = " ";
            FreeBSD = " ";
            Garuda = "󰛓 ";
            Gentoo = " ";
            HardenedBSD = "󰞌 ";
            Illumos = "󰈸 ";
            Kali = " ";
            Linux = " ";
            Mabox = " ";
            Macos = " ";
            Manjaro = " ";
            Mariner = " ";
            MidnightBSD = " ";
            Mint = " ";
            NetBSD = " ";
            NixOS = " ";
            OpenBSD = "󰈺 ";
            openSUSE = " ";
            OracleLinux = "󰌷 ";
            Pop = " ";
            Raspbian = " ";
            Redhat = " ";
            RedHatEnterprise = " ";
            RockyLinux = " ";
            Redox = "󰀘 ";
            Solus = "󰠳 ";
            SUSE = " ";
            Ubuntu = " ";
            Unknown = " ";
            Void = " ";
            Windows = "󰍲 ";
          };
          package = {
            symbol = "󰏗 ";
          };
          perl = {
            symbol = " ";
          };
          php = {
            symbol = " ";
          };
          pijul_channel = {
            symbol = " ";
          };
          python = {
            symbol = " ";
          };
          rlang = {
            symbol = "󰟔 ";
          };
          ruby = {
            symbol = " ";
          };
          rust = {
            symbol = "󱘗 ";
          };
          scala = {
            symbol = " ";
          };
          swift = {
            symbol = " ";
          };
          zig = {
            symbol = " ";
          };
        };
      };
    };
  };
}
