{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.t4sm5n = {
      isDefault = true;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        dashlane
        sponsorblock
        ublock-origin
      ];
    };
    policies = {
      EnableTrackingProtection = {
        Value = true;
      };
      OfferToSaveLogins = false;
      Preferences = {
        "general.autoScroll" = true;
      };
    };
  };
}
