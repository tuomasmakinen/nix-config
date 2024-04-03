{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles.t4sm5n = {
      extensions = with pkgs.inputs.firefox-addons; [ ublock-origin dashlane ];
    };
  };
}
