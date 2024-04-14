{ config, pkgs, ... }:
let inherit (config.colorscheme) palette;
in {
  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
    settings = {
      screenshot = true;
      clock = true;

      effect-blur = "7x5";
      effect-vignette = "0.5:0.5";
      fade-in = 0.5;

      color = "${palette.base00}b3";

      font = "Fira Sans";
      font-size = 48;

      ignore-empty-password = true;
      show-failed-attempts = true;
      show-keyboard-layout = true;

      line-uses-ring = true;
      disable-caps-lock-text = true;
      indicator-caps-lock = true;
      indicator-idle-visible = true;
      indicator-radius = 200;
      indicator-thickness = 20;

      ring-color = "#${palette.base02}";
      inside-wrong-color = "#${palette.base08}";
      ring-wrong-color = "#${palette.base08}";
      key-hl-color = "#${palette.base0B}";
      bs-hl-color = "#${palette.base08}";
      ring-ver-color = "#${palette.base09}";
      inside-ver-color = "#${palette.base09}";
      inside-color = "#${palette.base01}";
      text-color = "#${palette.base07}";
      text-clear-color = "#${palette.base01}";
      text-ver-color = "#${palette.base01}";
      text-wrong-color = "#${palette.base01}";
      text-caps-lock-color = "#${palette.base07}";
      inside-clear-color = "#${palette.base0C}";
      ring-clear-color = "#${palette.base0C}";
      inside-caps-lock-color = "#${palette.base09}";
      ring-caps-lock-color = "#${palette.base02}";
      separator-color = "#${palette.base02}";
    };
  };
}
