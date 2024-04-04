{ config, pkgs, lib, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "t4sm5n";
  home.homeDirectory = "/Users/t4sm5n";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    # pkgs.calibre
    pkgs.fira-code
    pkgs.nil
    pkgs.nixfmt
    pkgs.rustup
    pkgs.spotify
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/t4sm5n/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  nixpkgs = {
    overlays = [ inputs.nur.overlay ];
    config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [ "dashlane" "vscode" "spotify" ];
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

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
      mutableExtensionsDir = false;
    };
    zoxide = { enable = true; };
    zsh = {
      enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "robbyrussell";
      };
    };
  };
}
