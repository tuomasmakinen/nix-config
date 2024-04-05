{ pkgs, ... }: {
  home.packages = with pkgs; [
    unstable.jetbrains.rust-rover
    unstable.jetbrains.idea-community
  ];

  programs = {
    firefox = {
      enable = true;
      profiles.t4sm5n = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          dashlane
        ];
      };
    };
    kitty = {
      enable = true;
      font.name = "Fira Code";
      font.size = 12;
      shellIntegration.enableZshIntegration = true;
      theme = "Dracula";
    };
    vscode = {
      enable = true;
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      extensions = with pkgs.vscode-extensions;
        [ dracula-theme.theme-dracula jnoortheen.nix-ide ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
          name = "intellij-idea-keybindings";
          publisher = "k--kato";
          version = "1.6.1";
          sha256 = "X+jMqn8R6DxIjTb4v5HTRTYMmWmZiBRXdXOxCb0wwGU=";
        }];
      mutableExtensionsDir = false;
      userSettings = {
        # behavior
        "editor.formatOnSave" = true;

        # nix
        "[nix]"."editor.tabSize" = 2;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.serverSettings.nil.formatting.command" = [ "nixfmt" ];

        # style
        "workbench.colorTheme" = "Dracula";
        "editor.fontFamily" = "Fira Code";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 16;
      };
      package = pkgs.unstable.vscode;
    };
  };
}
