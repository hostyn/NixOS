{
  config,
  lib,
  vars,
  ...
}: let
  cfg = config.custom.shells.git;
in {
  options.custom.shells.git = {
    enable = lib.mkEnableOption true;
  };

  config = lib.mkIf cfg.enable {
    programs = {
      git = {
        enable = true;
      };
    };

    home-manager.users.${vars.user}.programs = {
      git = {
        enable = true;
        userName = "hostyn";
        userEmail = "ruben@martinezhostyn.com";

        extraConfig = {
          init.defaultBranch = "main";
          color.ui = "auto";
        };
      };

      ssh = {
        enable = true;
        matchBlocks = {
          github = {
            host = "github.com";
            user = "git";
            identityFile = "~/.ssh/id_ed25519";
            extraOptions = {
              PreferredAuthentications = "publickey";
              AddKeysToAgent = "yes";
              IPQos = "none";
            };
          };
        };
      };
    };
  };
}
