{ outputs, lib, pkgs, ... }: {
  imports = [ outputs.darwinTrampolines ./global ];
  home.homeDirectory = lib.mkForce "/Users/t4sm5n";
  programs.firefox.enable = lib.mkForce false;
  programs.kitty.font.size = lib.mkForce 16;

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };
}
