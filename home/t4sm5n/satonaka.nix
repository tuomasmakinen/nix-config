{
  outputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    # outputs.darwinTrampolines
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

  programs.zsh.initExtra = ''
  eval "$(/opt/homebrew/bin/brew shellenv)"
  . ~/.asdf/plugins/java/set-java-home.zsh
  '';
  programs.zsh.oh-my-zsh.plugins = [ "asdf" ];

  programs.git.includes = [
    {
      path = "~/work/digione/.gitconfig";
      condition = "gitdir:~/work/digione/";
    }
  ];
}
