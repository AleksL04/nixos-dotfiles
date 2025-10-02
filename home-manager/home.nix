{ config, pkgs, ... }:

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
  };
in {
  imports = [
    ./modules/neovim.nix
    ./modules/theme.nix
    ./modules/vscode.nix
    ./modules/xdg_desktop.nix
  ];
  home.username = "aleks";
  home.homeDirectory = "/home/aleks";
  programs.git.enable = true;
  home.stateVersion = "25.05";
  programs.bash = { enable = true; };
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    pulseaudio # Provides pactl, pacmd, etc.
    jq # The eww/waybar scripts also need this
    mpvpaper
    ffmpeg
    libnotify
    pywal
    imagemagick
    grim # The screenshot utility
    slurp # For selecting a screen region
    swappy # For editing and saving the screenshot
    wl-clipboard
  ];

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
}
