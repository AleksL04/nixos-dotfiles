{ inputs,pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
    	inputs.viu.packages.${pkgs.system}.default # <-- This will now work
    ];
}
