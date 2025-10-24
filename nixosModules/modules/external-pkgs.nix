{ inputs, pkgs, pkgs-unstable, ... }: {

  environment.systemPackages = (with pkgs; [
    inputs.viu.packages.${pkgs.system}.default
    inputs.swww.packages.${pkgs.system}.swww
    ##inputs.zen-browser.packages.${pkgs.system}.default
  ]) ++ (with pkgs-unstable; [ gemini-cli ]);
}
