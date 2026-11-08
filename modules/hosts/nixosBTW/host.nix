{ den, ... }:
{
  den.aspects.nixosBTW = {
    includes = with den.aspects.roles; [ base desktop tools ];

    nixos = {
     networking.hostName = "nixosBTW";
     home-manager.backupFileExtension = "hm-bak";
     imports = [./_hardware-configuration.nix];
     boot.kernelParams = ["radeon.dpm=0"];
    };
  };
}
