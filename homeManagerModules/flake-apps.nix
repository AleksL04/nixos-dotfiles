{ inputs, pkgs, ... }: {

  home.packages = [
    inputs.viu.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.swww.packages.${pkgs.stdenv.hostPlatform.system}.swww
  ];
}
