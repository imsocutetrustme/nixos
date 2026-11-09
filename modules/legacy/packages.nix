# TEMPORARY. Delete entries as Phases 3-7 replace them; delete the file after Phase 7.
{ den, ... }:
{
  den.aspects.legacy.packages = {
    includes = [
      (den.batteries.unfree [
        "steam"
        "steam-unwrapped"
        "steam-original"
        "steam-run"
        "discord"
        "discord-unwrapped"
      ])
    ];

    nixos = { pkgs, ... }: {
      programs.steam = {
        enable = true;
        extraCompatPackages = [ pkgs.proton-ge-bin ];
      };

      programs.gamemode.enable = true;

      hardware.graphics = {
        enable = true;
        enable32Bit = true;
      };

      environment.systemPackages = with pkgs; [
        kdePackages.kate firefox
      ];
    };
  };
}
