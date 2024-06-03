{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    gnome.dconf-editor
    gnomeExtensions.alphabetical-app-grid
    gnomeExtensions.appindicator
    gnomeExtensions.caffeine
    gnomeExtensions.dash-to-dock
    gnomeExtensions.user-themes
    nordic
    zafiro-nord-dark
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
    "org/gnome/desktop/input-sources" = {
      show-all-sources = true;
      sources = [
        (lib.hm.gvariant.mkTuple [
          "xkb"
          "eu"
        ])
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "ULauncher";
      command = "ulauncher-toggle";
      binding = "<Super>space";
    };
    "org/gnome/desktop/background" = {
      picture-options = "center";
      picture-uri = toString pkgs.wallpapers.wallpaper;
      picture-uri-dark = toString pkgs.wallpapers.wallpaper;
    };
    "org/gnome/desktop/screensaver" = {
      picture-options = "center";
      picture-uri = toString pkgs.wallpapers.wallpaper;
      picture-uri-dark = toString pkgs.wallpapers.wallpaper;
    };
    "org/gnome/desktop/wm/preferences" = {
      theme = "Nordic-standard-buttons";
      titlebar-font = "Noto Sans Bold 10";
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "AlphabeticalAppGrid@stuarthayhurst"
        "appindicatorsupport@rgcjonas.gmail.com"
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
