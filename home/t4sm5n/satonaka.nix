{ outputs, lib, ... }: {
  imports = [ outputs.darwinTrampolines ./global ];
  home.homeDirectory = lib.mkForce "/Users/t4sm5n";
  programs.firefox.enable = lib.mkForce false;
  programs.kitty.font.size = lib.mkForce 14;

  programs.zsh.initExtra = "source <(kubectl completion zsh)";
}
