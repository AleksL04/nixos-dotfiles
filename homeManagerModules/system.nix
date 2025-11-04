{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Backends & Daemons
    pulseaudio
    qt5.qtwayland
    qt6.qtwayland
    libnotify

    # Media & Archives
    ffmpeg
    imagemagick
    unzip
    zip
    p7zip
  ];
}
