{ outputs, lib, ... }: {
  imports = [ outputs.darwinTrampolines ./global ];
  home.homeDirectory = lib.mkForce "/Users/t4sm5n";
}
