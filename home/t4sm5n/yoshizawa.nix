{
  outputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./features/cli
    ./features/desktop
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  home.packages = with pkgs; [
    bottles
    busybox
    calibre
    libreoffice
    logseq
    nh
    ranger
    usbutils
    quickemu
  ];

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
      # logseq requires eol electron version
      permittedInsecurePackages = [ "electron-28.3.3" ];
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  home = {
    username = "t4sm5n";
    homeDirectory = "/home/t4sm5n";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";
}
