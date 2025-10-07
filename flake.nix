{
  description = "NixOS from Scratch";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    viu.url = "github:Benexl/viu";
    swww.url = "github:LGFae/swww";
    hyprland.url = "github:hyprwm/Hyprland";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      system = "x86_64-linux";
      lib = inputs.nixpkgs.lib;
      pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs;
            inherit pkgs-unstable;
          };
          modules = [
            ./system/configuration.nix
            ./modules/external-pkgs.nix
            ./modules/hyprland.nix
            ./modules/local-pkgs.nix
            #./modules/kde.nix
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.aleks = import ./home-manager/home.nix;
                extraSpecialArgs = {
                  inherit pkgs-unstable; # <-- UNSTABLE
                };
                backupFileExtension = "backup";
              };
            }
          ];
        };
      };
    };
}
