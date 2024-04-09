{ outputs, lib, ... }: {
  imports = [ outputs.darwinTrampolines ./global ];
  home.homeDirectory = lib.mkForce "/Users/t4sm5n";
  programs.firefox.enable = lib.mkForce false;
  programs.kitty.font.size = lib.mkForce 16;
}
