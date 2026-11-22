{ den, ... }:
{
  den.aspects.gaming.modrinth = {
    includes = [ (den.batteries.unfree [ "modrinth-app" "modrinth-app-unwrapped" ]) ];
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.modrinth-app ];
    };
  };
}
