{ config, ... }:
let inherit (config.colorscheme) palette;
in {
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = map (m:
        let
          resolution = "${toString m.width}x${toString m.height}@${
              toString m.refreshRate
            }";
          position = "${toString m.x}x${toString m.y}";
        in "${m.name},${
          if m.enabled then "${resolution},${position},1" else "disable"
        }") (config.monitors);

      exec-once = [
        "gsettings set org.gnome.desktop.interface cursor-size 48"
        ''gsettings set org.gnome.desktop.interface gtk-theme "Nordic"''
        ''gsettings set org.gnome.desktop.wm.preferences theme "Nordic"''
        "exec-once=hyprctl setcursor Nordzy-cursors 24"
        "mako"
        "waybar"
        "swayidle -w timeout 1800 'swaylock' timeout 12000 'swaymsg \"output * dpms off\"' resume 'swaymsg \"output * dpms on\"' before-sleep 'swaylock'"
        "hyprpaper"
        "eww open-many weather uptime"
      ];

      layerrule = [ "blur,notifications" "blur,wofi" "blur,gtk-layer-shell" ];

      input = {
        kb_layout = "eu";
        follow_mouse = 1;
      };

      misc = {
        animate_manual_resizes = true;
        enable_swallow = true;
      };

      general = {
        gaps_in = 6;
        gaps_out = 6;
        border_size = 3;
        "col.active_border" =
          "rgb(${palette.base0C}) rgb(${palette.base0E}) rgb(${palette.base0A}) rgb(${palette.base0B}) 45deg";
      };

      decoration = {
        drop_shadow = true;
        shadow_range = 20;
        shadow_render_power = 3;
        "col.shadow" = "0xee1a1a1a";
        "col.shadow_inactive" = "0xee1a1a1a";
        rounding = 10;
        blur = {
          enabled = true;
          size = 5;
          passes = 3;
          new_optimizations = true;
          xray = true;
        };
      };

      animations = {
        enabled = 1;
        bezier =
          [ "easeOutQuint,0.22, 1, 0.36, 1" "easeOutSine,0.61, 1, 0.88, 1)" ];
        animation = [
          "windows,1,4,easeOutQuint,popin"
          "border,1,20,easeOutQuint"
          "fade,1,10,easeOutQuint"
          "workspaces,1,6,easeOutQuint,slidevert"
          "borderangle, 1, 30, easeOutSine, loop"
        ];
      };

      dwindle = {
        pseudotile = 1;
        force_split = 0;
      };

      "$mod" = "SUPER";

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      bind = [
        "$mod, RETURN, exec, kitty"
        "$mod, Q, killactive,"
        "$mod, M, exit,"
        "$mod, space, exec, wofi --show drun -I -G -o DP-2"
        "$mod, L, exec, swaylock"
        "$mod, left, movefocus, l"
        "$mod, down, movefocus, d"
        "$mod, up, movefocus, u"
        "$mod, right, movefocus, r"
        "$mod, g, togglegroup"
        "$mod, tab, changegroupactive"
      ];
    };
  };
}
