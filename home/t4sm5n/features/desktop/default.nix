{ pkgs, ... }:
{
  imports = [ ./vscode.nix ];

  programs = {
    firefox = {
      enable = true;
      profiles.t4sm5n = {
        isDefault = true;
        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          dashlane
          sponsorblock
          ublock-origin
        ];
      };
    };
    kitty = {
      enable = true;
      font.name = "Fira Code";
      font.size = 10.5;
      shellIntegration.enableZshIntegration = true;
      theme = "Nord";
    };
    thunderbird = {
      enable = true;
      profiles.t4sm5n = {
        isDefault = true;
      };
    };
  };
}
