{
  description = "XenStation Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/main";
    };

    alga = {
      url = "github:Tenzer/alga";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    blender-bin = {
      url = "https://flakehub.com/f/edolstra/blender-bin/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixvim,
    ...
  } @ inputs: {
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
