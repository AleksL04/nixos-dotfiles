{
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
    "application/pdf" = "libreoffice.desktop";
    # --- Text Files (now using our custom Neovim entry) ---
    "text/plain" = "neovim.desktop";
    "text/markdown" = "obsidian.desktop";
    "text/x-shellscript" = "neovim.desktop"; # For shell scripts

    # --- Images (using LibreWolf as a fallback) ---
    "image/jpeg" = "librewolf.desktop";
    "image/png" = "librewolf.desktop";
    "image/gif" = "librewolf.desktop";
    "image/webp" = "librewolf.desktop";

    # --- Videos (using LibreWolf as a fallback) ---
    "video/mp4" = "librewolf.desktop";
    "video/webm" = "librewolf.desktop";

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
