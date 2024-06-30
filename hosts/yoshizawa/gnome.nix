{ pkgs, ... }:
{
  environment.gnome.excludePackages =
    (with pkgs; [
      gedit
      gnome-console
      gnome-photos
      gnome-tour
    ])
    ++ (with pkgs.gnome; [
      cheese
      gnome-music
      gnome-terminal
      epiphany
      geary
      evince
      gnome-characters
      totem
      tali
      iagno
      hitori
      atomix
    ]);

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };
}
