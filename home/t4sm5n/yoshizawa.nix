{ nix-colors, ... }: {
  imports = [ nix-colors.homeManagerModules.default ./global ];
  colorScheme = nix-colors.colorSchemes.nord;
}
