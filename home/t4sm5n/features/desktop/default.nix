{ pkgs, ... }: {
  imports = [ ./vscode.nix ];

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
      font.size = 10;
      shellIntegration.enableZshIntegration = true;
      theme = "Nord";
    };
  };
}
