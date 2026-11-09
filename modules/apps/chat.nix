{ den, ... }:
{
  den.aspects.apps.chat = {
    includes = [ (den.batteries.unfree [ "discord" ]) ];
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        discord
        vesktop
        element-desktop
        cinny-desktop
      ];
    };
  };
}
