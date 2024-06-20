{
  inputs,
  outputs,
  lib,
  ...
}:

{
  imports = [ ../common ] ++ (builtins.attrValues outputs.darwinModules);

  # Packages to install
  # environment.systemPackages = with pkgs; [ ];

  # Packages to install with brew
  homebrew = {
    enable = true;
    brews = [ ];
    casks = [
      "alt-tab"
      "docker"
      "firefox"
      "obsidian"
      "rectangle"
      "sanesidebuttons"
      "scroll-reverser"
      "slack"
    ];
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
  };

  local.dock.enable = true;
  local.dock.entries = [
    { path = "/Applications/Slack.app"; }
    { path = "/Applications/Firefox.app"; }
    {
      path = "/nix/store/94wlqyrcvb3vr1bnxlh37avnajz6wnlr-home-manager-applications/Applications/kitty.app";
    }
    {
      path = "/nix/store/94wlqyrcvb3vr1bnxlh37avnajz6wnlr-home-manager-applications/Applications/Visual Studio Code.app";
    }
    {
      path = "/Users/t4sm5n";
      section = "others";
      options = "--view grid --display folder";
    }
    {
      path = "/Applications";
      section = "others";
      options = "--view grid --display folder";
    }
  ];

  # Broken on darwin
  nix.settings.auto-optimise-store = lib.mkForce false;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
