{
  description = "NixOS from Scratch";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    viu.url = "github:Benexl/viu";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    nixosConfigurations = {
    	nixos = inputs.nixpkgs.lib.nixosSystem {
      		system = "x86_64-linux";
		specialArgs = {
			inherit inputs;
		};
      		modules = [
        		./configuration.nix
			./modules/viu.nix
        		inputs.home-manager.nixosModules.home-manager
        		{
        		home-manager = {
            			useGlobalPkgs = true;
            			useUserPackages = true;
            			users.aleks = import ./home.nix;
            			backupFileExtension = "backup";
          		};
        		}
      		];
    	};
     };
  };
}
