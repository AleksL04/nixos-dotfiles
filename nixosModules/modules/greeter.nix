{ pkgs, ... }: {
  services.greetd = {
    enable = true;
    settings = {
      # This block runs the login screen (tuigreet) BEFORE you log in.
      # It does not and should not mention Hyprland.
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };
}
