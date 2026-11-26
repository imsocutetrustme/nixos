{ den, ... }:
{
  den.aspects.apps.notes = {
    includes = [ (den.batteries.unfree [ "obsidian" ]) ];

    homeManager = { pkgs, ... }: {
      programs.obsidian = {
        enable = true;

        package = pkgs.obsidian.override {
          commandLineArgs = "--ozone-platform=x11";
        };
      };
    };
  };
}
