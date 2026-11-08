{ den, ... }:
{
  den.aspects.dev.vscode = {
    includes = [ (den.batteries.unfree [ "vscode" ]) ];
    homeManager = { pkgs, lib, ... }: {
      programs.vscode = {
        enable = true;
        package = lib.hiPrio pkgs.vscode;
        profiles.default.userSettings = {
          "update.mode" = "none";
          "telemetry.telemetryLevel" = "off";
          "editor.fontSize" = 14;
        };
      };
    };
  };

  den.aspects.dev.vscodium.homeManager = { pkgs, ... }: {
    home.packages = [ pkgs.vscodium ];
  };
}
