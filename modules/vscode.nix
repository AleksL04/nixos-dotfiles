{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nixfmt # The formatter
    nil # The language server
  ];

  programs.vscode = {
    enable = true;

    extensions = with pkgs.vscode-extensions; [
      # --- Nix Essentials ---
      jnoortheen.nix-ide

      # --- Web Development ---
      esbenp.prettier-vscode # <-- ADDED: The Prettier formatter
      dbaeumer.vscode-eslint # Linter for JavaScript/TypeScript
      bradlc.vscode-tailwindcss # IntelliSense for Tailwind CSS

      # --- General Productivity ---
      usernamehw.errorlens # Highlights errors inline
      christian-kohler.path-intellisense # Autocompletes file paths
    ];

    userSettings = {
      # --- General Settings ---
      "workbench.sideBar.location" = "right";

      # --- Nix Language Server Settings ---
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.serverSettings" = {
        "nil" = { "formatting" = { "command" = [ "nixfmt" ]; }; };
      };

      # --- Language-Specific Settings ---
      # Set Prettier as the default formatter and enable format-on-save
      # for CSS, JSON, and JSONC files.
      "[css]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.formatOnSave" = true;
      };
      "[json]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.formatOnSave" = true;
      };
      "[jsonc]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.formatOnSave" = true;
      };
      "[nix]" = { "editor.formatOnSave" = true; };
    };
  };
}
