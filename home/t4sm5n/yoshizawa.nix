{ pkgs, ... }:
{
  imports = [
    ./global
    ./features/desktop/ulauncher
  ];

  home.packages = with pkgs; [
    beeper
    bottles
    calibre
    gnome.dconf-editor
    nh
    nordic
    obsidian
    ranger
    usbutils
    zafiro-nord-dark
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Nordic-standard-buttons";
      icon-theme = "Zafiro-Nord-Dark";
      cursor-theme = "Nordic-cursors";
      document-font-name = "Noto Sans 10";
      font-name = "Noto Sans 10";
      monospace-font-name = "Noto Sans Mono 10";
      font-antialiasing = "rgba";
      font-hinting = "none";
    };
    "org/gnome/desktop/background" = {
      picture-options = "zoom";
      picture-uri = "file:///home/t4sm5n/Pictures/nix-d-nord-aurora.jpg";
      picture-uri-dark = "file:///home/t4sm5n/Pictures/nix-d-nord-aurora.jpg";
    };
    "org/gnome/desktop/screensaver" = {
      picture-options = "zoom";
      picture-uri = "file:///home/t4sm5n/Pictures/nix-d-nord-aurora.jpg";
      picture-uri-dark = "file:///home/t4sm5n/Pictures/nix-d-nord-aurora.jpg";
    };
    "org/gnome/desktop/wm/preferences" = {
      theme = "Nordic";
      titlebar-font = "Noto Sans Bold 10";
    };
    "com/solus-project/budgie-panel" = {
      dark-theme = true;
    };
  };
}
