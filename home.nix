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
	wlogout = "wlogout";
	dunst = "dunst";
	kitty = "kitty";
	Thunar = "Thunar";
	eww = "eww";
    };
in
{
    imports = [
    	./modules/neovim.nix
	./modules/theme.nix
    ];
    home.username = "aleks";
    home.homeDirectory = "/home/aleks";
    programs.git.enable = true;
    home.stateVersion = "25.05";
    programs.bash = {
        enable = true;
    };
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
    	pulseaudio # Provides pactl, pacmd, etc.
    	jq         # The eww/waybar scripts also need this
	libnotify
	pywal
	imagemagick

    ];

    xdg.configFile = builtins.mapAttrs (name: subpath: {
        source = create_symlink "${dotfiles}/${subpath}";
        recursive = true;
    }) configs;
}
