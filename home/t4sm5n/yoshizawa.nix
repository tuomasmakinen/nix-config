{ pkgs, ... }:
{
  imports = [ ./global ];

  home.packages = with pkgs; [
    beeper
    #    calibre
    nh
    obsidian
    ranger
    usbutils
  ];
}
