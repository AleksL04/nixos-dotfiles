{ lib, config, ... }: {

  xdg.desktopEntries = {
    btop = {
      name = "btop";
      exec = "kitty --hold btop";
      terminal = false;
    };

    nvim = {
      name = "Neovim";
      exec = "nvim";
      terminal = true;
      noDisplay = true;
    };

    neovim = {
      name = "Neovim";
      comment = "Edit text files in Kitty";
      exec = "kitty nvim %U";
      terminal = false; # The desktop entry itself doesn't run in a terminal
      mimeType =
        [ "text/plain" "text/markdown" ]; # Associate it with text files
    };

    viu-media = {
      name = "Viu Media";
      comment = "Launch the Viu media application";
      exec = "kitty --hold viu";
      terminal = false;
    };
  };

  xdg.mimeApps.enable = lib.mkDefault true;
  xdg.configFile."mimeapps.list" =
    lib.mkIf config.xdg.mimeApps.enable { force = true; };
  xdg.mimeApps.defaultApplications = {
    # --- Set Thunar as default for folders ---
    "inode/directory" = "thunar.desktop";
    # --- Browser for web links ---
    "text/html" = "zen-beta.desktop";
    "x-scheme-handler/http" = "zen-beta.desktop";
    "x-scheme-handler/https" = "zen-beta.desktop";
    # --- PDF Files ---
    "application/pdf" = "zen-beta.desktop";
    # --- Text Files (now using our czen-betaustom Neovim entry) ---
    "text/plain" = "neovim.desktop";
    "text/markdown" = "obsidian.desktop";
    "text/x-shellscript" = "neovim.desktop"; # For shell scripts

    # --- Images (using zen-beta as a fallback) ---
    "image/jpeg" = "zen-beta.desktop";
    "image/png" = "zen-beta.desktop";
    "image/gif" = "zen-beta.desktop";
    "image/webp" = "zen-beta.desktop";

    # --- Videos (using zen-beta as a fallback) ---
    "video/mp4" = "zen-beta.desktop";
    "video/webm" = "zen-beta.desktop";

    # --- Archives ---
    "application/zip" = "xarchiver.desktop";
    "application/x-rar-compressed" = "xarchiver.desktop";
    "application/x-7z-compressed" = "xarchiver.desktop";
    "application/x-tar" = "xarchiver.desktop";
    "application/gzip" = "xarchiver.desktop";
    "application/x-bzip2" = "xarchiver.desktop";
    "application/x-xz" = "xarchiver.desktop";

    # --- Office Documents ---
    "application/vnd.oasis.opendocument.text" = "libreoffice.desktop";
    "application/vnd.oasis.opendocument.spreadsheet" = "libreoffice.desktop";
    "application/vnd.oasis.opendocument.presentation" = "libreoffice.desktop";
    "application/msword" = "libreoffice.desktop";
    "application/vnd.ms-excel" = "libreoffice.desktop";
    "application/vnd.ms-powerpoint" = "libreoffice.desktop";
  };
}
