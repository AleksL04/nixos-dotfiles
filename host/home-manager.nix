{ inputs, pkgs-unstable, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.aleks = {
      imports = [
        ./home.nix
        inputs.self.outputs.homeManagerModules.default

        inputs.zen-browser.homeModules.twilight
        inputs.spicetify-nix.homeManagerModules.spicetify
      ];
    };
    extraSpecialArgs = {
      inherit pkgs-unstable;
      inherit inputs;
    };
    backupFileExtension = "backup";
  };
}
