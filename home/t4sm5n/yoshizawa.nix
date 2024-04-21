{ pkgs, ... }:
let
  custom_mech = pkgs.python311Packages.mechanize.overridePythonAttrs (old: {
    doCheck = false;
  });
  custom_calibre = pkgs.calibre.override (old: {
    python3Packages = old.python3Packages // {
      mechanize = custom_mech;
    };
  });
in
{
  imports = [ ./global ];

  home.packages = with pkgs; [
    beeper
    custom_calibre
    lutris
    nh
    obsidian
    ranger
    usbutils
  ];

  xfconf.settings = {
    xfce4-keyboard-shortcuts = {
      "commands/custom/<Super>space" = "xfce4-appfinder -c";
      "commands/custom/<Super>space/startup-notify" = true;
    };
    xfce4-panel = {
      "panels/panel-1/output-name" = "Primary";
      "panels/panel-1/size" = 32;
      "panels/panel-2/output-name" = "Primary";
      "panels/panel-2/size" = 64;
    };
    xsettings = {
      "Gtk/CursorThemeName" = "Nordic-cursors";
      "Gtk/FontName" = "Fira Sans 10";
      "Gtk/MonospaceFontName" = "Fira Code 10";
      "Net/IconThemeName" = "Nordic-green";
      "Net/ThemeName" = "Nordic-standard-buttons";
    };
  };
}
