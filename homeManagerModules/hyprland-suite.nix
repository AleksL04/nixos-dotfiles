{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # -----------------------------------------------------
    # Desktop & User Interface
    # -----------------------------------------------------
    dunst # Notification daemon
    eww # Elkowars Wacky Widgets
    hyprlock # Hyprland screen locker
    hyprpaper # Hyprland wallpaper utility
    hypridle
    kitty # Terminal emulator
    networkmanagerapplet # System tray icon for network management
    nwg-look # GTK3 settings editor for Wayland
    qt5.qtwayland # Qt5 Wayland support
    qt6.qtwayland # Qt6 Wayland support
    waybar # Wayland bar
    wlogout # Wayland logout menu
    wofi # Application launcher
    swaynotificationcenter
    zoom-us

    # -----------------------------------------------------
    # GUI Applications
    # -----------------------------------------------------
    librewolf # Web browser
    prismlauncher # Minecraft launcher
    vesktop # Discord client
    xfce.thunar # File manager
    obsidian # Note-taking application
    libreoffice # Office suite
    filezilla
    powertop
    # -----------------------------------------------------
    # Multimedia, Theming & Scripting Dependencies
    # -----------------------------------------------------
    ffmpeg # Video and audio converter
    imagemagick # Image manipulation
    jq # Command-line JSON processor (for eww/waybar scripts)
    mpvpaper # Video wallpaper player
    playerctl # Control media players
    pulseaudio # Sound server (provides pactl, pacmd)
    pywal # Theming tool
    pavucontrol
    socat

    # -----------------------------------------------------
    # CLI & System Utilities
    # -----------------------------------------------------
    btop # Resource monitor
    brightnessctl # Control screen brightness
    fastfetch # System information tool
    git # Version control
    grim # Screenshot utility for Wayland
    libnotify # Send desktop notifications
    neofetch # System information tool
    slurp # Select a region on screen
    swappy # Screenshot editing tool
    wget # Network downloader
    wl-clipboard # Wayland clipboard utilities
    gamescope # Steam games compatibility layer for Wayland
    direnv
    nix-direnv

    xarchiver
    unzip
    zip
    p7zip
  ];
}
