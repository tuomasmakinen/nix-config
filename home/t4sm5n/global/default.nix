{ inputs, outputs, lib, config, pkgs, ... }: {
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      outputs.overlays.nur-packages
    ];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home.packages = with pkgs; [ fira-code nil nixfmt rustup ];

  programs = {
    firefox = {
      enable = false;
      profiles.t4sm5n = {
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          dashlane
        ];
      };
    };
    git = {
      enable = true;
      userName = "t4sm5n";
      userEmail = "28858039+t4sm5n@users.noreply.github.com";
      extraConfig = { init = { defaultBranch = "main"; }; };
      diff-so-fancy.enable = true;
    };
    kitty = {
      enable = true;
      font.name = "Fira Code";
      font.size = 16;
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
    zoxide = { enable = true; };
    zsh = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      # autosuggestion.enable = true; TODO why u no work?
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "robbyrussell";
      };
    };
  };

  home = {
    username = lib.mkDefault "t4sm5n";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
