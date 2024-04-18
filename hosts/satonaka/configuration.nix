{ inputs, lib, pkgs, ... }:

{
  imports = [ ../common ];

  environment.systemPackages = with pkgs; [ unstable.devenv ];

  homebrew = {
    enable = true;
    casks =
      [ "alt-tab" "beeper" "docker" "obsidian" "rectangle" "sanesidebuttons" ];
  };

  nix.settings.auto-optimise-store = lib.mkForce false;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision =
    inputs.self.rev or inputs.self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
