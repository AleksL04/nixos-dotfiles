{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
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
