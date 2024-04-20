{ pkgs, ... }:
{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ];

  users.users.t4sm5n = {
    isNormalUser = true;
    description = "Tuomas Mäkinen";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
