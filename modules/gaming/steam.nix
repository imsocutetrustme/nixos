{ den, ... }:
{
  den.aspects.gaming.steam = {
    includes = [
      (den.batteries.unfree [ "steam" "steam-unwrapped" "steam-original" "steam-run" ])
    ];

    nixos = { pkgs, ... }: {
      programs.steam = {
        enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };
    };
  };
}
