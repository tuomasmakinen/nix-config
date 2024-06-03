{ pkgs, ... }:
{
  imports = [
    ./global
    ./features/desktop/gnome
    ./features/desktop/ulauncher
  ];

  home.packages = with pkgs; [
    beeper
    bottles
    busybox
    calibre
    cider
    guitarix
    libreoffice
    nh
    obsidian
    ranger
    usbutils
    quickemu
  ];
}
