{
  outputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    outputs.darwinTrampolines
    ./global
  ];
  home.homeDirectory = lib.mkForce "/Users/t4sm5n";
  programs.firefox.enable = lib.mkForce false;
  programs.thunderbird.enable = lib.mkForce false;
  programs.kitty.font.size = lib.mkForce 14;

  home.packages = with pkgs; [
    glab
    kubectl
  ];

  programs.zsh.initExtra = ''eval "$(/opt/homebrew/bin/brew shellenv)"'';
  programs.git.includes = [
    {
      path = "~/work/digione/.gitconfig";
      condition = "gitdir:~/work/digione/";
    }
  ];
}
