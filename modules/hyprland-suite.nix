{ pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland.enable = true;

  # List Hyprland-related packages
  environment.systemPackages = with pkgs; [
    waybar
    kitty
    wofi
    dunst # Notification daemon
    networkmanagerapplet
    qt5.qtwayland
    qt6.qtwayland
    hyprpaper
    hyprlock
    wlogout
    playerctl
    nwg-look
    eww
  ];
}
