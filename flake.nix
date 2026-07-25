{
  description = "XenStation Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
    };

    alga = {
      url = "github:Tenzer/alga";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    blender-bin.url = "https://flakehub.com/f/edolstra/blender-bin/*";

  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    nixvim,
    alga,
    ...
  }: {
    nixosConfigurations.xenstation = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;
      };

      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";

            users.xeneye = {
              imports = [
                nixvim.homeModules.nixvim
                ./home.nix
              ];
            };
          };
        }
      ];
    };
  };
}
