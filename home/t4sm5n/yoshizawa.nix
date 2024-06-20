{ pkgs, ... }:
{
  imports = [
    ./global
    ./features/desktop/gnome
  ];

  # logseq requires eol electron version
  nixpkgs.config.permittedInsecurePackages = [ "electron-27.3.11" ];

  home.packages = with pkgs; [
    beeper
    bottles
    busybox
    calibre
    cider
    guitarix
    libreoffice
    logseq
    nh
    obsidian
    ranger
    usbutils
    quickemu
  ];
}
