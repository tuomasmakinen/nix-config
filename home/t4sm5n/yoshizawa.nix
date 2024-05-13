{ pkgs, ... }:
{
  imports = [
    ./global
    ./features/desktop/ulauncher
  ];

  home.packages = with pkgs; [
    beeper
    bottles
    busybox
    calibre
    gnome.dconf-editor
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.caffeine
    gnomeExtensions.dash-to-dock
    gnomeExtensions.user-themes
    guitarix
    libreoffice
    nh
    obsidian
    ranger
    usbutils
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Zafiro-Nord-Dark";
      package = pkgs.zafiro-nord-dark;
    };
    theme = {
      name = "Nordic-standard-buttons";
      package = pkgs.nordic;
    };
    cursorTheme = {
      name = "Nordic-cursors";
      package = pkgs.nordic;
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  home.sessionVariables.GTK_THEME = "Nordic-standard-buttons";

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
      enable-hot-corners = false;
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
      theme = "Nordic-standard-buttons";
      titlebar-font = "Noto Sans Bold 10";
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "AlphabeticalAppGrid@stuarthayhurst"
        "caffeine@patapon.info"
        "dash-to-dock@micxgx.gmail.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
      favorite-apps = [
        "org.gnome.Calendar.desktop"
        "org.gnome.Nautilus.desktop"
        "firefox.desktop"
        "kitty.desktop"
        "code.desktop"
      ];
    };
    "org/gnome/shell/extensions/caffeine" = {
      toggle-state = true;
    };
    "org/gnome/shell/extensions/dash-to-dock" = {
      multi-monitor = true;
      intellihide = false;
      background-opacity = 0.5;
      custom-background-color = true;
      background-color = "rgb(59,66,82)";
    };
    "org/gnome/shell/extensions/user-theme" = {
      name = "Nordic-standard-buttons";
    };
  };
}
