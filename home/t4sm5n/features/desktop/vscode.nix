{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nil
    nixfmt-rfc-style
  ];

  programs = {
    vscode = {
      enable = true;
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;
      extensions =
        with pkgs.vscode-extensions;
        [
          arcticicestudio.nord-visual-studio-code
          rust-lang.rust-analyzer
          jnoortheen.nix-ide
          arrterian.nix-env-selector
          # Java
          redhat.java
          visualstudioexptteam.vscodeintellicode
          vscjava.vscode-gradle
          # Kotlin
          mathiasfrohlich.kotlin
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "linuxkeybindings";
            publisher = "fredhappyface";
            version = "1.87.2";
            sha256 = "YGFyYuOcTCwUrc6mGaM3vm7c7+XW5TxHiAAs5n86rOM=";
          }
          {
            name = "bpmn-vscode-extension";
            publisher = "kie-group";
            version = "0.32.0";
            sha256 = "rOzbP6eUUEX5ETKwKgqXHSN8oPQHQ6QerAit+V3jWow=";
          }
        ];
      mutableExtensionsDir = false;
      userSettings = {
        # behavior
        "editor.formatOnSave" = true;

        # nix
        "[nix]"."editor.tabSize" = 2;
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.serverSettings" = {
          "nil" = {
            formatting.command = [ "nixfmt" ];
            nix.flake.autoArchive = true;
          };
        };

        # style
        "workbench.colorTheme" = "Nord";
        "editor.fontFamily" = "Fira Code";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 14;
        "terminal.integrated.fontFamily" = "Fira Code";
        "terminal.integrated.fontSize" = 14;
      };
    };
  };
}
