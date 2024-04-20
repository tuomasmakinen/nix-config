{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:

{
  imports = [
    ./display.nix
    ./hardware-additional.nix
    ./hardware-configuration.nix
    ./locale.nix
    ./users.nix
    ../common
  ] ++ (builtins.attrValues outputs.nixosModules);

  environment.sessionVariables = {
    FLAKE = "/home/t4sm5n/nix-config";
  };

  environment.systemPackages = with pkgs; [
    git
    nordic
  ];

  fonts.packages = with pkgs; [ fira ];

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  security.sudo.wheelNeedsPassword = false;

  networking = {
    hostName = "yoshizawa";
    networkmanager.enable = true;
  };

  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; })) (
    (lib.filterAttrs (_: lib.isType "flake")) inputs
  );

  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "23.11";
}
