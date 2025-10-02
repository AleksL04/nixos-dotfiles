{ inputs, pkgs, ... }: {
  programs.hyprland.enable = true;
  environment.systemPackages = with pkgs; [
    inputs.viu.packages.${pkgs.system}.default
    inputs.swww.packages.${pkgs.system}.swww
  ];
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
}
