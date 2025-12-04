{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Interactive Tools
    btop
    powertop
    fastfetch # or neofetch
    wget
    git
    direnv
    nix-direnv
    lazydocker

    # Scripting Dependencies
    jq
    socat
    fzf
  ];
}
