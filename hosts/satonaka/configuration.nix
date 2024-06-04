{ inputs, lib, ... }:

{
  imports = [ ../common ];

  # Packages to install
  # environment.systemPackages = with pkgs; [ ];

  # Packages to install with brew
  homebrew = {
    enable = true;
    brews = [ "dnsmasq" ];
    casks = [
      "alt-tab"
      "android-platform-tools"
      "docker"
      "obsidian"
      "rectangle"
      "sanesidebuttons"
    ];
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
  };

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
