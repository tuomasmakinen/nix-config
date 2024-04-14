{ nix-colors, ... }: {
  imports = [
    nix-colors.homeManagerModules.default
    ./global
    ./features/desktop/wayland
  ];

  colorScheme = nix-colors.colorSchemes.nord;

  monitors = [
    {
      name = "DP-3";
      width = 2560;
      height = 1440;
      x = 0;
      workspace = 2;
    }
    {
      name = "DP-2";
      primary = true;
      width = 2560;
      height = 1440;
      refreshRate = 144;
      x = 2560;
      workspace = 1;
    }
  ];
}
