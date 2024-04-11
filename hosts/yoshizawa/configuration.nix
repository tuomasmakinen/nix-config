{ inputs, lib, config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ../common ];

  fonts.packages = with pkgs; [ fira ];

  environment.systemPackages = with pkgs; [ unstable.obsidian unstable.beeper ];

  services.autorandr = {
    enable = true;
    profiles = {
      "default" = {
        fingerprint = {
          DP-2 =
            "00ffffffffffff0004722f05c4ad30742b1b0104a53c227806ee91a3544c99260f505421080001010101010101010101010101010101565e00a0a0a029503020350056502100001a000000ff0023415350706b346d7434794464000000fd001e9022de3b010a202020202020000000fc005842323731485520410a2020200106020312412309070183010000654b040001015a8700a0a0a03b503020350056502100001a5aa000a0a0a046503020350056502100001a6fc200a0a0a055503020350056502100001a22e50050a0a0675008203a0056502100001e1c2500a0a0a011503020350056502100001a0000000000000000000000000000000000000019";
          DP-3 =
            "00ffffffffffff0030aeec61000000000d1e0104a53c22783ab4a5ad4f449e250f5054a54b00d100d1c0b300714f81809500a9c0a9cf565e00a0a0a029503020350055502100001a000000fd00324c1e5a19010a202020202020000000fc004c454e20543237682d32300a20000000ff00564e4134443350480a2020202001d7020318f14b101f05140413121103020123097f0783010000f520a05050841a300820c80055502100001a0734805070381f400820180455502100001a6d24405060841a300820c80055502100001a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a1";
        };
        config = {
          DP-3 = {
            enable = true;
            position = "0x0";
            mode = "2560x1440";
          };
          DP-2 = {
            enable = true;
            primary = true;
            position = "2560x0";
            mode = "2560x1440";
            rate = "144.00";
          };
        };
      };
    };
  };

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.plasma5.enable = true;
    xkb.layout = "eu";
    xrandrHeads = [
      "DP-3"
      {
        output = "DP-2";
        primary = true;
      }
    ];
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
  };

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  environment.pathsToLink = [ "/share/zsh" ];

  users.users.t4sm5n = {
    isNormalUser = true;
    description = "Tuomas Mäkinen";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  security.sudo.wheelNeedsPassword = false;

  networking = {
    hostName = "yoshizawa";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Helsinki";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fi_FI.UTF-8";
    LC_IDENTIFICATION = "fi_FI.UTF-8";
    LC_MEASUREMENT = "fi_FI.UTF-8";
    LC_MONETARY = "fi_FI.UTF-8";
    LC_NAME = "fi_FI.UTF-8";
    LC_NUMERIC = "fi_FI.UTF-8";
    LC_PAPER = "fi_FI.UTF-8";
    LC_TELEPHONE = "fi_FI.UTF-8";
    LC_TIME = "fi_FI.UTF-8";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: { inherit flake; }))
    ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = [ "/etc/nix/path" ];
  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
