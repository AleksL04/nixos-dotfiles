{
  description = "NixOS from Scratch";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    viu.url = "github:Benexl/viu";
    swww.url = "github:LGFae/swww";
    hyprland.url = "github:hyprwm/Hyprland";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      system = "x86_64-linux";
      lib = inputs.nixpkgs.lib;
      pkgs-unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
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
            ./modules/docker.nix
            ./modules/greeter.nix
            ./modules/spicetify.nix

            inputs.spicetify-nix.nixosModules.spicetify

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
