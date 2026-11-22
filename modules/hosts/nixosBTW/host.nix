{ den, ... }:
{
  den.aspects.nixosBTW = {
    includes = with den.aspects.roles; [
      base
      desktop
      tools
      apps
      gaming

      den.aspects.nixosBTW.disko
    ];

    nixos = {
     networking.hostName = "nixosBTW";
     home-manager.backupFileExtension = "hm-bak";
     imports = [ ./_hardware-configuration.nix ];
    };
  };
}
