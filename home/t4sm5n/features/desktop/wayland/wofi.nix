{ config, pkgs, ... }:
let inherit (config.colorscheme) palette;
in {
  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 1200;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 40;
      gtk_dark = true;
    };
    style = ''
      * {
      	font-family: "Fira Code Nerd Font", "Font Awesome";
          font-weight: bold;
          font-size: 22px;
      }

      @define-color white_front #D8DEE9;

      window {
      	background-color: #3B4252;
        border-radius: 10px
      }

      #input {
      	margin: 5px;
      	border-radius: 0px;
      	border: none;
      	background-color: #3B4252;
      	color: @white_front;
      }

      #inner-box {
      	background-color: #383C4A;
      }

      #outer-box {
      	margin: 2px;
      	padding: 10px;
      	background-color: #383C4A;
      }

      #scroll {
      	margin: 5px;
      }

      #text {
      	padding: 4px;
      	color: @white_front;
      }

      #entry:nth-child(even) {
      	background-color: #404552;
      }

      #entry:selected {
      	background-color: #4C566A;
      }

      #text:selected {
      	background: transparent;
      }
    '';
  };
}
