{ config, pkgs, ... }:
let
  inherit (config.colorscheme) palette;
  wlogoutIcons = "${pkgs.wlogout}/share/wlogout/icons";
in {
  programs.wlogout = {
    enable = true;
    style = ''
      * {
      	background-image: none;
      }

      window {
      	background-color: rgba(46, 52, 64, 0.9);
      }

      button {
      	background-color: #2e3440;
      	border-style: solid;
      	border-width: 0px;
      	border-radius: 0;
      	background-repeat: no-repeat;
      	background-position: center;
      	background-size: 25%;
      	color: #5e81ac;
      }

      button:focus, button:active, button:hover {
      	background-color: #4c566a;
      	color: #81a1c1;
      	outline-style: none;
      }

      #lock {
          background-image: image(url("${wlogoutIcons}/lock.png"));
          color: #5E81AC;
      }

      #logout {
          background-image: image(url("${wlogoutIcons}/logout.png"));
          color: #B48EAD;
      }

      #suspend {
          background-image: image(url("${wlogoutIcons}/suspend.png"));
          color: #D08770;
      }

      #hibernate {
          background-image: image(url("${wlogoutIcons}/hibernate.png"));
          color: #EBCB8B;
      }

      #shutdown {
          background-image: image(url("${wlogoutIcons}/shutdown.png"));
          color: #BF616A;
      }

      #reboot {
          background-image: image(url("${wlogoutIcons}/reboot.png"));
          color: #A3BE8C;
      }
    '';
  };
}
