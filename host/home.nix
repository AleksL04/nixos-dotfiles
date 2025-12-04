{ config, lib, inputs, ... }:

let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
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
  home.username = "aleks";
  home.homeDirectory = "/home/aleks";
  programs.git.enable = true;
  home.stateVersion = "25.11";
  programs.bash = {
    enable = true;
    shellAliases = {
      gemini = ''
        docker run -it --rm --user root --env-file ~/.docker-secrets.env -w /app -v "$(pwd):/app" -v ~/.gemini:/root/.gemini naoyoshinori/gemini-cli:0-node gemini'';
    };
  };
  programs.home-manager.enable = true;
  programs.fzf.enableBashIntegration = true;

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
