{ den, ... }:
{
  den.aspects.apps.notes = {
    includes = [ (den.batteries.unfree [ "obsidian" ]) ];
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.obsidian ];
    };
  };
}
