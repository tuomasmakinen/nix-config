{ config, pkgs, ... }:
{
  age.secrets = {
    "t4sm5n/password".file = ./secrets/t4sm5n/password.age;
  };

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
    passwordFile = config.age.secrets."t4sm5n/password".path;
  };

  security.sudo.wheelNeedsPassword = false;
}
