{ lib, ... }: {
  imports = [ ./global ];
  home.homeDirectory = lib.mkForce "/Users/t4sm5n";
}
