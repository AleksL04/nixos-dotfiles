{ inputs, pkgs, pkgs-unstable, ... }: {
  environment.systemPackages = (with pkgs; [
    inputs.viu.packages.${pkgs.system}.default
    inputs.swww.packages.${pkgs.system}.swww
  ]) ++ (with pkgs-unstable; [ gemini-cli ]);
}
