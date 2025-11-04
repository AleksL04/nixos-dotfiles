{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Shell & Session
    hyprlock
    hyprpaper
    hypridle
    waybar
    eww
    wofi
    wlogout
    swaynotificationcenter
    networkmanagerapplet

    # GUI Applications
    kitty
    xfce.thunar
    xarchiver
    librewolf
    vesktop
    zoom-us
    filezilla
    obsidian
    libreoffice
    prismlauncher
    gamescope
    pavucontrol

    # Desktop Utilities
    grim
    slurp
    swappy
    wl-clipboard
    playerctl
    brightnessctl
    nwg-look
    pywal
    mpvpaper
  ];
}
