{
  config,
  lib,
  vars,
  pkgs,
  ...
}: let
  cfg = config.custom.programs.codium;
in {
  options.custom.programs.codium = {
    enable = lib.mkEnableOption "Visual Studio Code";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${vars.user} = {
      programs.vscode = {
        enable = true;
        package = pkgs.vscode;
        enableUpdateCheck = false;

        # User settings
        userSettings = {
          "breadcrumbs.showArrays" = false;
          "breadcrumbs.showBooleans" = false;
          "breadcrumbs.showClasses" = false;
          "breadcrumbs.showConstants" = false;
          "breadcrumbs.showConstructors" = false;
          "breadcrumbs.showEnumMembers" = false;
          "breadcrumbs.showEnums" = false;
          "breadcrumbs.showEvents" = false;
          "breadcrumbs.showFields" = false;
          "breadcrumbs.showFiles" = false;
          "breadcrumbs.showFunctions" = false;
          "breadcrumbs.showInterfaces" = false;
          "breadcrumbs.showKeys" = false;
          "breadcrumbs.showMethods" = false;
          "breadcrumbs.showModules" = false;
          "breadcrumbs.showNamespaces" = false;
          "breadcrumbs.showNull" = false;
          "breadcrumbs.showNumbers" = false;
          "breadcrumbs.showObjects" = false;
          "breadcrumbs.showOperators" = false;
          "breadcrumbs.showPackages" = false;
          "breadcrumbs.showProperties" = false;
          "breadcrumbs.showStrings" = false;
          "breadcrumbs.showStructs" = false;
          "breadcrumbs.showTypeParameters" = false;
          "breadcrumbs.showVariables" = false;

          "editor.cursorBlinking" = "expand";
          "editor.cursorSmoothCaretAnimation" = "on";
          "editor.fontFamily" = "'Mononoki Nerd Font Mono', 'CaskaydiaCove Nerd Font'";
          "editor.fontSize" = 16;
          "editor.formatOnSave" = true;
          "editor.guides.bracketPairs" = true;
          "editor.linkedEditing" = true;
          "editor.minimap.enabled" = false;
          "editor.renderWhitespace" = "none";
          "editor.tabSize" = 2;

          "explorer.confirmDelete" = false;
          "explorer.confirmDragAndDrop" = false;
          "explorer.confirmPasteNative" = false;

          "window.menuBarVisibility" = "toggle";

          "security.workspace.trust.enabled" = false;

          "workbench.activityBar.location" = "hidden";
          "workbench.colorTheme" = "GitHub Dark";
          "workbench.iconTheme" = "material-icon-theme";
          "git.autofetch" = true;
          "git.confirmSync" = false;

          "redhat.telemetry.enabled" = false;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "nix.formatterPath" = "alejandra";
          "nix.serverSettings" = {
            "nixd" = {
              "formatting" = {
                "command" = ["alejandra"];
              };
              "options" = {
                "nixos" = {
                  "expr" = "(builtins.getFlake \"/home/${vars.user}/NixOS\").nixosConfigurations.${vars.hostname}.options";
                };
                "home-manager" = {
                  "expr" = "(builtins.getFlake \"/home/${vars.user}/NixOS\").homeConfigurations.${vars.hostname}.options";
                };
              };
            };
          };

          "gitlens.plusFeatures.enabled" = false;
          "gitlens.keymap" = "none";
          "gitlens.telemetry.enabled" = false;

          "[json]" = {
            "editor.defaultFormatter" = "vscode.json-language-features";
          };
          "[typescript]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[typescriptreact]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[javascript]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[javascriptreact]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[html]" = {
            "editor.defaultFormatter" = "vscode.html-language-features";
          };
          "[dockerfile]" = {
            "editor.defaultFormatter" = "ms-azuretools.vscode-docker";
          };
          "[yaml]" = {
            "editor.defaultFormatter" = "redhat.vscode-yaml";
          };
        };

        # Extensions
        extensions =
          (with pkgs.vscode-marketplace; [
            bbenoist.nix
            jnoortheen.nix-ide

            # Theming
            github.github-vscode-theme
            pkief.material-icon-theme

            # Node
            dbaeumer.vscode-eslint
            esbenp.prettier-vscode
            bradlc.vscode-tailwindcss
            prisma.prisma
            usernamehw.errorlens

            # Git / GitHub
            eamodio.gitlens
            mhutchie.git-graph
            github.vscode-github-actions

            # Copilot
            github.copilot
            # github.copilot-chat

            # Python
            ms-python.black-formatter
            ms-python.debugpy
            ms-python.isort
            ms-python.python

            # Astro
            unifiedjs.vscode-mdx
            astro-build.astro-vscode

            # Other
            ms-azuretools.vscode-docker
            ms-kubernetes-tools.vscode-kubernetes-tools
            ms-vscode.live-server
            redhat.vscode-yaml
            tomoki1207.pdf

            vivaxy.vscode-conventional-commits
            yoavbls.pretty-ts-errors
          ])
          ++ (with pkgs.vscode-extensions; [github.copilot-chat]); # Use nixpkgs extension because vscode-marketplace requires code ^1.96.0

        # User snippets
        globalSnippets = {
          "console.log" = {
            prefix = "clg";
            body = "console.log(\${1:value})";
            description = "console.log shortcut";
            scope = "javascript,javascriptreact,typescript,typescriptreact";
          };
        };
      };
    };
  };
}
