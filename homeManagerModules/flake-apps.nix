{ inputs, pkgs, ... }: {

  home.packages = [
    inputs.viu.packages.${pkgs.system}.default
    inputs.swww.packages.${pkgs.system}.swww
  ];
}
