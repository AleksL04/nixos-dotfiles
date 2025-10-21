{ pkgs, pkgs-unstable, ... }:

{
  home.packages = with pkgs; [ nixfmt-classic nil ];

  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscode;
    profiles.default = {
      extensions = with pkgs-unstable.vscode-extensions; [
        # --- Nix Essentials ---
        jnoortheen.nix-ide

        # --- Web Development ---
        esbenp.prettier-vscode # <-- ADDED: The Prettier formatter
        dbaeumer.vscode-eslint # Linter for JavaScript/TypeScript
        bradlc.vscode-tailwindcss # IntelliSense for Tailwind CSS

        # --- General Productivity ---
        usernamehw.errorlens # Highlights errors inline
        christian-kohler.path-intellisense # Autocompletes file paths
        ms-azuretools.vscode-containers # Docker support
        ms-toolsai.jupyter # Jupyter Notebooks support
        ms-python.python # Python support
        ms-vscode.cpptools # C/C++ support
        ms-vscode-remote.remote-containers # Remote - Containers
        vscodevim.vim

        arrterian.nix-env-selector
        mikestead.dotenv
        ms-python.black-formatter
        ms-python.vscode-pylance

      ];

      userSettings = {
        # --- General Settings ---
        "workbench.sideBar.location" = "right";
        "git.confirmSync" = "false";
        "update.mode" = "none";
        "python.analysis.extraPaths" = [ ".venv\\Lib\\site-packages" ];

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
  };
}
