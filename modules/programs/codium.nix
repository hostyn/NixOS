{ config, lib, vars, pkgs, ... }:

let
  cfg = config.custom.programs.codium;
in
{
  options.custom.programs.codium = {
    enable = lib.mkEnableOption "Visual Studio Code";
  };

  config = lib.mkIf cfg.enable {
    home-manager.users.${vars.user} = {
      programs.vscode = {
        enable = true;
        package = pkgs.vscode-fhs;
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
          "security.workspace.trust.untrustedFiles" = "open";
          "workbench.activityBar.location" = "hidden";
          "workbench.colorTheme" = "GitHub Dark";
          "workbench.iconTheme" = "material-icon-theme";
          "git.autofetch" = true;
          "redhat.telemetry.enabled" = false;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "nixd";
          "git.confirmSync" = false;

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
        extensions = with pkgs.vscode-extensions; [
          # Nix
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
          github.copilot-chat

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
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "vscode-conventional-commits";
            publisher = "vivaxy";
            version = "1.25.0";
            sha256 = "sha256-KPP1suR16rIJkwj8Gomqa2ExaFunuG42fp14lBAZuwI=";
          }
          {
            name = "pretty-ts-errors";
            publisher = "yoavbls";
            version = "0.6.0";
            sha256 = "sha256-cmleAs7EMXT1z0o8Uq5ne2LrthUt/vhcN+iqfAy/i/8=";
          }
        ];

        # Remove all GitLens keybindings to fix Ctrl+Shift+G
        keybindings = [
          {
            key = "ctrl+shift+g g";
            command = "-workbench.view.scm";
            when = "workbench.scm.active && !gitlens:disabled && config.gitlens.keymap == 'chorded'";
          }
          {
            key = "ctrl+shift+g shift+h";
            command = "-gitlens.showQuickRepoHistory";
            when = "!gitlens:disabled && config.gitlens.keymap == 'chorded'";
          }
          {
            key = "ctrl+shift+g h";
            command = "-gitlens.showQuickFileHistory";
            when = "!gitlens:disabled && config.gitlens.keymap == 'chorded'";
          }
          {
            key = "ctrl+shift+g s";
            command = "-gitlens.showQuickRepoStatus";
            when = "!gitlens:disabled && config.gitlens.keymap == 'chorded'";
          }
          {
            key = "ctrl+shift+g shift+7";
            command = "-gitlens.gitCommands";
            when = "!gitlens:disabled && config.gitlens.keymap == 'chorded'";
          }
          {
            key = "ctrl+shift+g [Period]";
            command = "-gitlens.diffWithNext";
            when = "editorTextFocus && !isInDiffEditor && config.gitlens.keymap == 'chorded' && gitlens:activeFileStatus =~ /revision/";
          }
          {
            key = "ctrl+shift+g [Period]";
            command = "-gitlens.diffWithNextInDiffRight";
            when = "editorTextFocus && isInDiffRightEditor && config.gitlens.keymap == 'chorded' && gitlens:activeFileStatus =~ /revision/";
          }
          {
            key = "ctrl+shift+g [Period]";
            command = "-gitlens.diffWithNextInDiffLeft";
            when = "editorTextFocus && isInDiffEditor && !isInDiffRightEditor && config.gitlens.keymap == 'chorded' && gitlens:activeFileStatus =~ /revision/";
          }
          {
            key = "ctrl+shift+g [Comma]";
            command = "-gitlens.diffWithPrevious";
            when = "editorTextFocus && !isInDiffEditor && config.gitlens.keymap == 'chorded' && gitlens:activeFileStatus =~ /tracked/";
          }
          {
            key = "ctrl+shift+g [Comma]";
            command = "-gitlens.diffWithPreviousInDiffLeft";
            when = "editorTextFocus && isInDiffEditor && !isInDiffRightEditor && config.gitlens.keymap == 'chorded' && gitlens:activeFileStatus =~ /tracked/";
          }
          {
            key = "ctrl+shift+g [Comma]";
            command = "-gitlens.diffWithPreviousInDiffRight";
            when = "editorTextFocus && isInDiffRightEditor && config.gitlens.keymap == 'chorded' && gitlens:activeFileStatus =~ /tracked/";
          }
          {
            key = "ctrl+shift+g shift+[IntlBackslash]";
            command = "-gitlens.diffWithWorking";
            when = "editorTextFocus && config.gitlens.keymap == 'chorded' && gitlens:activeFileStatus =~ /revision/";
          }
          {
            key = "ctrl+shift+g ctrl+shift+alt+x";
            command = "-gitlens.diffWithWorking";
            when = "editorTextFocus && config.gitlens.keymap == 'chorded' && gitlens:activeFileStatus =~ /revision/";
          }
          {
            key = "ctrl+shift+g [IntlBackslash]";
            command = "-gitlens.diffLineWithPrevious";
            when = "editorTextFocus && config.gitlens.keymap == 'chorded' && gitlens:activeFileStatus =~ /tracked/";
          }
          {
            key = "ctrl+shift+g ctrl+shift+alt+z";
            command = "-gitlens.diffLineWithPrevious";
            when = "editorTextFocus && config.gitlens.keymap == 'chorded' && gitlens:activeFileStatus =~ /tracked/";
          }
          {
            key = "ctrl+shift+g c";
            command = "-gitlens.showQuickCommitFileDetails";
            when = "editorTextFocus && !gitlens:disabled && config.gitlens.keymap == 'chorded'";
          }
          {
            key = "ctrl+shift+g b";
            command = "-gitlens.toggleFileBlame";
            when = "editorTextFocus && config.gitlens.keymap == 'chorded' && gitlens:activeFileStatus =~ /blameable/";
          }
          {
            key = "ctrl+shift+g shift+b";
            command = "-gitlens.toggleCodeLens";
            when = "editorTextFocus && !gitlens:disabled && !gitlens:disabledToggleCodeLens && config.gitlens.keymap == 'chorded'";
          }
          {
            "key" = "ctrl+shift+g [Period]";
            "command" = "-gitlens.diffWithNext";
            "when" = "editorTextFocus && gitlens:enabled && !isInDiffEditor && config.gitlens.keymap == 'chorded' && resourceScheme =~ /^(gitlens|git|pr)$/";
          }
          {
            "key" = "ctrl+shift+g [Period]";
            "command" = "-gitlens.diffWithNextInDiffLeft";
            "when" = "editorTextFocus && gitlens:enabled && isInDiffEditor && !isInDiffRightEditor && config.gitlens.keymap == 'chorded' && resourceScheme =~ /^(gitlens|git|pr)$/";
          }
          {
            "key" = "ctrl+shift+g [Period]";
            "command" = "-gitlens.diffWithNextInDiffRight";
            "when" = "editorTextFocus && gitlens:enabled && isInDiffRightEditor && config.gitlens.keymap == 'chorded' && resourceScheme =~ /^(gitlens|git|pr)$/";
          }
          {
            "key" = "ctrl+shift+g [Comma]";
            "command" = "-gitlens.diffWithPrevious";
            "when" = "editorTextFocus && !isInDiffEditor && config.gitlens.keymap == 'chorded' && resource in 'gitlens:tabs:tracked'";
          }
          {
            "key" = "ctrl+shift+g [Comma]";
            "command" = "-gitlens.diffWithPreviousInDiffLeft";
            "when" = "editorTextFocus && isInDiffEditor && !isInDiffRightEditor && config.gitlens.keymap == 'chorded' && resource in 'gitlens:tabs:tracked'";
          }
          {
            "key" = "ctrl+shift+g [Comma]";
            "command" = "-gitlens.diffWithPreviousInDiffRight";
            "when" = "editorTextFocus && isInDiffRightEditor && config.gitlens.keymap == 'chorded' && resource in 'gitlens:tabs:tracked'";
          }
          {
            "key" = "ctrl+shift+g shift+[IntlBackslash]";
            "command" = "-gitlens.diffWithWorking";
            "when" = "editorTextFocus && gitlens:enabled && config.gitlens.keymap == 'chorded' && resourceScheme =~ /^(gitlens|git|pr)$/";
          }
          {
            "key" = "ctrl+shift+g ctrl+shift+alt+x";
            "command" = "-gitlens.diffWithWorking";
            "when" = "editorTextFocus && gitlens:enabled && config.gitlens.keymap == 'chorded' && resourceScheme =~ /^(gitlens|git|pr)$/";
          }
          {
            "key" = "ctrl+shift+g [IntlBackslash]";
            "command" = "-gitlens.diffLineWithPrevious";
            "when" = "editorTextFocus && config.gitlens.keymap == 'chorded' && resource in 'gitlens:tabs:tracked'";
          }
          {
            "key" = "ctrl+shift+g ctrl+shift+alt+z";
            "command" = "-gitlens.diffLineWithPrevious";
            "when" = "editorTextFocus && config.gitlens.keymap == 'chorded' && resource in 'gitlens:tabs:tracked'";
          }
          {
            "key" = "ctrl+shift+g b";
            "command" = "-gitlens.toggleFileBlame";
            "when" = "editorTextFocus && config.gitlens.keymap == 'chorded' && resource in 'gitlens:tabs:blameable'";
          }
          {
            "key" = "ctrl+shift+g shift+h";
            "command" = "-gitlens.showQuickRepoHistory";
            "when" = "!gitlens:disabled && config.gitlens.keymap == 'chorded'";
          }
          {
            "key" = "ctrl+shift+g";
            "command" = "-workbench.action.terminal.openDetectedLink";
            "when" = "accessibleViewIsShown && terminalHasBeenCreated && accessibleViewCurrentProviderId == 'terminal'";
          }
          {
            "key" = "ctrl+shift+g g";
            "command" = "-workbench.view.scm";
            "when" = "workbench.scm.active && !gitlens:disabled && config.gitlens.keymap == 'chorded'";
          }
        ];

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

