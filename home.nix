{ config, pkgs, ... }:

let
    dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
    # Standard .config/directory
    configs = {
        waybar = "waybar";
        wofi = "wofi";
	hypr = "hypr";
	scripts = "scripts";
    };
in
{
    home.username = "aleks";
    home.homeDirectory = "/home/aleks";
    programs.git.enable = true;
    home.stateVersion = "25.05";
    programs.bash = {
        enable = true;
    	shellAliases = {
	  btw = "echo i use nixos, btw";
    	};
    };
    xdg.configFile = builtins.mapAttrs (name: subpath: {
        source = create_symlink "${dotfiles}/${subpath}";
        recursive = true;
    }) configs;
}
