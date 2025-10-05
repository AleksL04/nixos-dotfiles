{ inputs, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    inputs.viu.packages.${pkgs.system}.default
    inputs.swww.packages.${pkgs.system}.swww
  ];

}
