{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles = {
      default = {
        enableUpdateCheck = false;
        extensions = with pkgs.vscode-extensions; [
          biomejs.biome
          eamodio.gitlens
          mkhl.direnv
          dotenv.dotenv-vscode
          llvm-vs-code-extensions.vscode-clangd
          zainchen.json
          yzhang.markdown-all-in-one
          ms-python.isort
          ms-python.black-formatter
          ms-python.python
          ms-python.pylint
          ms-python.debugpy
          ms-python.mypy-type-checker
          ms-python.vscode-pylance
          ms-python.flake8
          ms-vscode.powershell
          sumneko.lua
          tamasfe.even-better-toml
          vscodevim.vim
          jnoortheen.nix-ide
          waderyan.gitblame
          reditorsupport.r
          redhat.vscode-xml
          redhat.vscode-yaml
        ];
        keybindings = [
          {
            key = "ctrl+shift+t";
            command = "workbench.action.createTerminalEditor";
          }
        ];
        userSettings = {
          "editor.cursorBlinking" = "solid";
          "editor.codeLens" = false;
          "editor.fontFamily" = "'JetBrainsMono Nerd Font Mono', Monaco, Consolas";
          "editor.fontSize" = 14.0;
          "editor.fontVariations" = true;
          "editor.fontWeight" = "700";
          "editor.guides.bracketPairs" = "active";
          "editor.guides.bracketPairsHorizontal" = false;
          "editor.hover.delay" = 1000;
          "editor.minimap.enabled" = false;
          "editor.parameterHints.enabled" = false;
          "editor.quickSuggestionsDelay" = 300;
          "editor.quickSuggestions" = {
            "other" = true;
            "comments" = false;
            "strings" = false;
          };
          "editor.renderLineHighlight" = "none";
          "editor.semanticHighlighting.enabled" = false;
          "extensions.autoUpdate" = false;
          "extensions.experimental.affinity" = {
            "vscode.vim" = 1;
          };
          "files.watcherExclude" = {
            "**/.git/objects/**" = true;
            "**/.git/subtree-cache/**" = true;
            "**/.hg/store/**" = true;
            "**/node_modules/*" = true;
            "**/.venv/**" = true;
          };
          "git.decorations.enabled" = false;
          "git.countBadge" = "off";
          "window.zoomLevel" = -0.65;
          "workbench.enableExperiments" = false;
          "workbench.reduceMotion" = "on";
          "workbench.editor.enablePreview" = false;
          "workbench.settings.editor" = "json";
          "workbench.startupEditor" = "none";
          "search.followSymlinks" = false;
          "search.exclude" = {
            "**/node_modules" = true;
            "**/bower_components" = true;
            "**/*.code-search" = true;
            "**/.venv" = true;
          };
          "telemetry.telemetryLevel" = "off";
          "update.showReleaseNotes" = false;
          "update.mode" = "manual";
          "vim.useSystemClipboard" = true;
          "vim.highlightedyank.enable" = true;
          "vim.leader" = "<space>";
          "vim.handleKeys" = {
            "<C-a>" = false;
            "<C-f>" = false;
          };
          "vim.insertModeKeyBindings" = [
            {
              "before" = [
                "j"
                "k"
              ];
              "after" = [
                "<Esc>"
              ];
            }
          ];
          "vim.normalModeKeyBindingsNonRecursive" = [
            {
              "before" = [ "<C-h>" ];
              "after" = [
                "<C-w>"
                "h"
              ];
            }
            {
              "before" = [ "<C-j>" ];
              "after" = [
                "<C-w>"
                "j"
              ];
            }
            {
              "before" = [ "<C-k>" ];
              "after" = [
                "<C-w>"
                "k"
              ];
            }
            {
              "before" = [ "<C-l>" ];
              "after" = [
                "<C-w>"
                "l"
              ];
            }
            {
              "before" = [
                "<leader>"
                "f"
                "f"
              ];
              "commands" = [ "workbench.action.quickOpen" ];
            }
            {
              "before" = [
                "<leader>"
                "f"
                "b"
              ];
              "commands" = [ "workbench.action.showAllEditors" ];
            }
            {
              "before" = [
                "<leader>"
                "f"
                "o"
              ];
              "commands" = [ "workbench.action.openRecent" ];
            }
            {
              "before" = [
                "<leader>"
                "f"
                "r"
              ];
              "commands" = [ "workbench.action.openNewEditor" ];
            }
            {
              "before" = [
                "<leader>"
                "f"
                "s"
              ];
              "commands" = [ "workbench.action.gotoSymbol" ];
            }
            {
              "before" = [
                "<leader>"
                "f"
                "w"
              ];
              "commands" = [ "workbench.action.showAllSymbols" ];
            }
            {
              "before" = [
                "<leader>"
                "<leader>"
                "<leader>"
              ];
              "commands" = [ "workbench.action.showCommands" ];
            }
          ];
        };
      };
    };
  };
}
