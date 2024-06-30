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
    ./backup.nix
    ./disko.nix
    ./gnome.nix
    ./hardware-additional.nix
    ./hardware-configuration.nix
    ./locale.nix
    ./users.nix
    ./vm.nix
  ] ++ (builtins.attrValues outputs.nixosModules);

  fonts.packages = [ pkgs.fira-code ];

  virtualisation = {
    podman.enable = true;
    waydroid.enable = true;
    spiceUSBRedirection.enable = true;
  };

  environment = {
    sessionVariables = {
      FLAKE = "/home/t4sm5n/nix-config";
    };
    systemPackages = with pkgs; [
      curl
      git
      kitty
      neovim
    ];
  };

  programs.steam = {
    enable = true;
  };

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  age.identityPaths = [ "${config.users.users.t4sm5n.home}/.ssh/id_ed25519" ];

  networking = {
    hostName = "yoshizawa";
    networkmanager.enable = true;
  };

  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };

  nix = {
    nixPath = [ "/etc/nix/path" ];
    registry = (lib.mapAttrs (_: flake: { inherit flake; })) (
      (lib.filterAttrs (_: lib.isType "flake")) inputs
    );
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  system.stateVersion = "24.05";
}
