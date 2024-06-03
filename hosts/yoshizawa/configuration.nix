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
    ./desktop.nix
    ./hardware-additional.nix
    ./hardware-configuration.nix
    ./locale.nix
    ./users.nix
    ../common
  ] ++ (builtins.attrValues outputs.nixosModules);

  fonts.packages = [ pkgs.fira-code ];

  virtualisation = {
    docker.enable = true;
    waydroid.enable = true;
    spiceUSBRedirection.enable = true;
  };

  environment.sessionVariables = {
    FLAKE = "/home/t4sm5n/nix-config";
  };

  programs.steam = {
    enable = true;
  };

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

  services.printing.enable = true;

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

  system.stateVersion = "23.11";
}
