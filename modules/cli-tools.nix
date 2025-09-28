{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    git
    unzip
    zip
    btop # A better resource monitor
    neofetch # For system info
    fastfetch
    jq
    brightnessctl
  ];
}
