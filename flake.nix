{
  description = "t4sm5n nix flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Nix-darwin
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Nix User Repository
    nur.url = "github:nix-community/nur";

    mac-app-util.url = "github:hraban/mac-app-util";
    mac-app-util.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // nix-darwin.lib // home-manager.lib;
      systems = [ "x86_64-linux" "aarch64-darwin" ];
      forAllSystems = f:
        nixpkgs.lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        });
    in {
      inherit lib;
      nixosModules = import ./modules/nixos;
      homeManagerModules = import ./modules/home-manager;
      darwinTrampolines = inputs.mac-app-util.homeManagerModules.default;

      overlays = import ./overlays { inherit inputs outputs; };

      packages = forAllSystems (pkgs: import ./pkgs { inherit pkgs; });
      formatter = forAllSystems (pkgs: pkgs.nixfmt);

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          modules = [ ./hosts/desktop/configuration.nix ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      # Darwin configuration entrypoint
      # Available through 'darwin-rebuild --flake .#your-hostname'
      darwinConfigurations = {
        satonaka = nix-darwin.lib.darwinSystem {
          modules = [ ./hosts/satonaka/configuration.nix ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        "t4sm5n@desktop" = home-manager.lib.homeManagerConfiguration {
          modules = [ ./home/t4sm5n/desktop.nix ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        "t4sm5n@satonaka" = home-manager.lib.homeManagerConfiguration {
          modules = [ ./home/t4sm5n/satonaka.nix ];
          pkgs = pkgsFor.aarch64-darwin;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
