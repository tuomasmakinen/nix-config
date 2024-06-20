{ pkgs, ... }:
{
  imports = [
    ./global
    ./features/desktop/gnome
  ];

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
