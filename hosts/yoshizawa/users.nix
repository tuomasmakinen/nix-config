{ ... }:
{
  users.users.t4sm5n = {
    isNormalUser = true;
    description = "Tuomas Mäkinen";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
