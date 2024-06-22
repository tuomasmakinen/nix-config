{ config, pkgs, ... }:
{
  # age.secrets = {
  #   "t4sm5n/password".file = ./secrets/t4sm5n/password.age;
  # };

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
    initialPassword = "t4sm5n";
    # hashedPasswordFile = config.age.secrets."t4sm5n".path;
  };

  security.sudo.wheelNeedsPassword = false;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIHITV+pHVxACLwqovX5DxcHHwLX2NGMNqk5WGjaPRZY t4sm5n@yoshizawa"
  ];
}
