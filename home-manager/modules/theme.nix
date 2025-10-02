{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [
    (catppuccin-kvantum.override {
      accent = "blue";
      variant = "macchiato";
    })
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    papirus-folders
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.libsForQt5.breeze-gtk;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
      gtk-cursor-theme-name = "catppuccin-mocha-light-cursors";
    };
    gtk4.extraConfig = {
      Settings = ''
        				gtk-application-prefer-dark-theme = true;
                gtk-cursor-theme-name=catppuccin-mocha-light-cursors    		
      '';
    };

  };

  dconf.settings = {
    "org/gnome/desktop/interface" = { "color-scheme" = "prefer-dark"; };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "catppuccin-mocha-light-cursors";
    package = pkgs.catppuccin-cursors.mochaLight;
    size = 24;
  };
}
