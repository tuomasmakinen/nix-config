{ config, pkgs, ... }:
let
  inherit (config.colorscheme) palette;
  nordzyIcons = "${pkgs.nordzy-icon-theme}/share/icons";
in {
  services.mako = {
    enable = true;
    iconPath = "${nordzyIcons}";
    font = "Fira Code 12";
    padding = "10,20";
    anchor = "top-center";
    width = 400;
    height = 150;
    borderSize = 2;
    defaultTimeout = 12000;
    backgroundColor = "#${palette.base00}dd";
    borderColor = "#${palette.base03}dd";
    textColor = "#${palette.base05}dd";
    layer = "overlay";
  };
}
