{ config, pkgs, ... }:

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
  };
in {
  imports = [ ./modules/neovim.nix ./modules/theme.nix ./modules/vscode.nix ];
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

  xdg.desktopEntries."neovim" = {
    name = "Neovim";
    comment = "Edit text files in Kitty";
    exec = "kitty nvim %U";
    terminal = false; # The desktop entry itself doesn't run in a terminal
    categories = [ "Utility" "TextEditor" ];
    mimeType = [ "text/plain" "text/markdown" ]; # Associate it with text files
  };

  xdg.desktopEntries."viu-media" = {
    # The name that will appear in application launchers like wofi
    name = "Viu Media";

    # A short description of the application
    comment = "Launch the Viu media application";

    # The command to execute.
    # 'kitty --hold' runs the command and keeps the terminal window open
    # after the 'viu' process has exited.
    exec = "kitty --hold viu";

    # This must be false because we are explicitly launching a terminal in the exec command.
    terminal = false;

    # Application categories for menu organization
    categories = [ "Utility" "AudioVideo" "Player" ];
  };

  # 2. Define all your default applications
  xdg.mimeApps.defaultApplications = {
    # --- Set Thunar as default for folders ---
    "inode/directory" = "thunar.desktop";

    # --- Browser for web links ---
    "text/html" = "librewolf.desktop";
    "x-scheme-handler/http" = "librewolf.desktop";
    "x-scheme-handler/https" = "librewolf.desktop";

    # --- PDF Files ---
    "application/pdf" = "librewolf.desktop";

    # --- Text Files (now using our custom Neovim entry) ---
    "text/plain" = "neovim.desktop";
    "text/markdown" = "neovim.desktop";
    "text/x-shellscript" = "neovim.desktop"; # For shell scripts

    # --- Images (using LibreWolf as a fallback) ---
    "image/jpeg" = "librewolf.desktop";
    "image/png" = "librewolf.desktop";
    "image/gif" = "librewolf.desktop";
    "image/webp" = "librewolf.desktop";

    # --- Videos (using LibreWolf as a fallback) ---
    "video/mp4" = "librewolf.desktop";
    "video/webm" = "librewolf.desktop";
  };

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;
}
