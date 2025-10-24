{ config, lib, inputs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/home-manager/config";
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
    wal = "wal";
    swaync = "swaync";
  };
in {
  imports = [
    inputs.zen-browser.homeModules.twilight
    ./modules/neovim.nix
    ./modules/theme.nix
    ./modules/vscode.nix
    ./modules/xdg_desktop.nix
    ./modules/hyprland-suite.nix
    ./modules/zen.nix
  ];
  home.username = "aleks";
  home.homeDirectory = "/home/aleks";
  programs.git.enable = true;
  home.stateVersion = "25.05";
  programs.bash = { enable = true; };
  programs.home-manager.enable = true;

  xdg.configFile = (builtins.mapAttrs (name: subpath: {

    source = create_symlink "${dotfiles}/${subpath}";

    recursive = true;

  }) configs)

    //

    {
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=catppuccin-macchiato-blue
      '';
    };
}
