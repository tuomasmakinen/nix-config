{
  pkgs ? import <nixpkgs> { },
  ...
}:
rec {
  # example = pkgs.callPackage ./example { };
  wallpapers = import ./wallpapers { };
  allWallpapers = pkgs.linkFarmFromDrvs "wallpapers" (pkgs.lib.attrValues wallpapers);
  zafiro-nord-dark = pkgs.callPackage ./zafiro-nord-dark { };
}
