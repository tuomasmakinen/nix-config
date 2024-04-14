{ pkgs, ... }: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oa: {
      mesonFlags = (oa.mesonFlags or [ ]) ++ [ "-Dexperimental=true" ];
    });
    settings = {
      primary = {
        layer = "top";
        icon-theme = "Nordzy-dark";
        modules-left = [ "custom/wlogout" "wlr/taskbar" "tray" ];
        modules-center = [ "hyprland/workspaces" ];
        modules-right = [ "memory" "cpu" "pulseaudio" "clock" ];

        "wlr/taskbar" = {
          format = "{icon}";
          icon-size = 30;
          icon-theme = "Nordzy-dark";
          tooltip-format = "{title}";
          on-click = "activate";
          on-click-right = "close";
        };

        tray = {
          "icon-size" = 24;
          "spacing" = 10;
          "icon-theme" = "Nordzy-dark";
        };

        "hyprland/workspaces" = {
          window-rewrite = { };
          format = "{icon}";
          on-click = "activate";
          all-outputs = true;
          format-icons = {
            "1" = "web";
            "2" = "msg";
            "3" = "dev";
            "4" = "sys";
            "5" = "idk";
            urgent = "";
          };
        };

        "memory" = {
          "interval" = 5;
          "format" = " {}%";
          "max-length" = 10;
          "on-click" = "kitty -e btop";
        };

        "cpu" = {
          "interval" = 5;
          "format" = " {}%";
          "max-length" = 10;
          "on-click" = "kitty -e btop";
        };

        pulseaudio = {
          tooltip = false;
          scroll-step = 5;
          format = "{icon} {volume}%";
          format-muted = "{icon} {volume}%";
          on-click = "pavucontrol";
          format-icons = { default = [ "" "" "" ]; };
        };

        "clock" = {
          "format" = "{: %H:%M}";
          "timezone" = "Europe/Helsinki";
        };

        "custom/wlogout" = {
          "format" = "";
          "interval" = "once";
          "on-click" = "wlogout";
        };
      };
    };
    style = ''
      @keyframes blink-warning {
        70% {
          color: @light;
        }

        to {
          color: @light;
          background-color: @warning;
        }
      }

      @keyframes blink-critical {
        70% {
          color: @light;
        }

        to {
          color: @light;
          background-color: @critical;
        }
      }

      /* COLORS */

      /* Nord */

      /* Polar Night */
      @define-color nord0 #2E3440;
      @define-color nord1 #3B4252;
      @define-color nord2 #434C5E;
      @define-color nord3 #4C566A;
      /* Snow Storm */
      @define-color nord4 #D8DEE9;
      @define-color nord5 #E5E9F0;
      @define-color nord6 #ECEFF4;
      /* Frost */
      @define-color nord7 #8FBCBB;
      @define-color nord8 #88C0D0;
      @define-color nord9 #81A1C1;
      @define-color nord10 #5E81AC;
      /* Aurora */
      @define-color nord11 #BF616A;
      @define-color nord12 #D08770;
      @define-color nord13 #EBCB8B;
      @define-color nord14 #A3BE8C;
      @define-color nord15 #B48EAD;

      /* Quick Access */
      @define-color bg rgba(46, 52, 64, 0.7);  /* nord0 but with transparency */
      @define-color fg @nord4;

      @define-color red @nord11;
      @define-color orange @nord12;
      @define-color yellow @nord13;
      @define-color green @nord14;
      @define-color blue @nord10;
      @define-color violet @nord15;

      @define-color night0 @nord0;
      @define-color night1 @nord1;
      @define-color night2 @nord2;
      @define-color night3 @nord3;

      @define-color snow0 @nord4;
      @define-color snow1 @nord5;
      @define-color snow2 @nord6;

      @define-color frost0 @nord7;
      @define-color frost1 @nord8;
      @define-color frost2 @nord9;
      @define-color frost3 @nord10;

      @define-color aurora0 @nord11;
      @define-color aurora1 @nord12;
      @define-color aurora2 @nord13;
      @define-color aurora3 @nord14;
      @define-color aurora4 @nord15;

      @define-color light @snow0;
      @define-color warning @aurora2;
      @define-color critical @aurora0;
      @define-color mode @night2;
      @define-color layout @frost3;
      @define-color battery @frost1;
      @define-color backlight @night2;

      /* Reset all styles */
      * {
        background-color: transparent;
        border: none;
        border-radius: 10px;
        border-width: 4px;
        min-height: 0;
        margin: 1px 6px 1px 6px;
      }

      /* The whole bar */
      #waybar {
        background-color: transparent;
        color: @fg;
        font-family: "Hurmit Nerd Font", "Font Awesome";
        font-size: 22px;
        font-weight: bold;
        border-radius: 0px;
      }

      /* Each module */
      #custom-wlogout,
      #taskbar,
      #tray,
      #workspaces,
      #memory #cpu,
      #clock {
        background-color: @night0;
      }

      /* indicators */
      #memory,
      #cpu,
      #pulseaudio,
      #clock {
        padding-right: 5px;
        padding-left: 5px;
        border-radius: 0px;
        border-style: solid none solid none;
        border-color: @night1;
        margin-right: 0px;
        margin-left: 0px;
        background-color: @night0;
      }

      /* Each module that should blink */
      #mode,
      #memory,
      #temperature,
      #battery {
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      /* Each critical module */
      #memory.critical,
      #cpu.critical,
      #temperature.critical,
      #battery.critical {
        color: @critical;
      }

      /* Each critical that should blink */
      #mode,
      #memory.critical,
      #temperature.critical,
      #battery.critical.discharging {
        animation-name: blink-critical;
        animation-duration: 2s;
      }

      /* Each warning */
      #network.disconnected,
      #memory.warning,
      #cpu.warning,
      #temperature.warning,
      #battery.warning {
        background: @warning;
        color: @nord_dark_font;
      }

      /* Each warning that should blink */
      #battery.warning.discharging {
        animation-name: blink-warning;
        animation-duration: 3s;
      }

      /* And now modules themselves in their respective order */

      #custom-wlogout {
        padding: 7px;
        padding-right: 10px;
        color: @red;
        border-color: @night1;
        border-style: solid;
      }

      /* taskbar */
      #taskbar {
        border-color: @night1;
        border-style: solid;
      }

      #taskbar button:hover {
        background-color: @frost2;
      }

      #tray {
        border-color: @night1;
        border-style: solid;
      }

      /* Workspaces stuff */

      #workspaces {
        margin-right: 10px;
        border-color: @night1;
        border-style: solid;
      }

      #workspaces button {
        font-weight: bold;
        /* Somewhy the bar-wide setting is ignored*/
        padding: 0;
      }

      #workspaces button:hover {
        background-color: @frost2;
      }

      #workspaces button.active {
        color: @green;
        border-color: @green;
      }

      #workspaces button.urgent {
        border-color: @red;
        color: @red;
      }

      #window {
        margin-right: 40px;
        margin-left: 40px;
        font-weight: bold;
        font-size: 22px;
      }

      #memory {
        /* it's the most left indicator */
        border-radius: 10px 0px 0px 10px;
        border-style: solid none solid solid;
        color: @blue;
      }

      #cpu {
        color: @green;
      }

      #cpu.warning {
        color: @yellow;
      }

      #cpu.critical {
        color: @red;
      }

      #language {
        padding: 0 0.4em;
      }

      #temperature {
        color: @green;
      }

      #temperature.critical {
        color: @red;
      }

      #pulseaudio {
        color: @violet;
      }

      #pulseaudio.muted {
        color: @red;
        /* No styles */
      }

      #pulseaudio.source-muted {
        color: @orange;
        /* No styles */
      }

      #clock {
        /* it's the most right indicator */
        border-radius: 0px 10px 10px 0px;
        border-style: solid solid solid none;
        color: @frost0;
      }

      #clock.time {
        color: @frost0;
      }
    '';
  };
}
