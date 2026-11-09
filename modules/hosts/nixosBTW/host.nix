{ den, ... }:
{
  den.aspects.nixosBTW = {
    includes = with den.aspects.roles; [ base desktop tools apps ];

    nixos = {
     networking.hostName = "nixosBTW";
     home-manager.backupFileExtension = "hm-bak";
     imports = [./_hardware-configuration.nix];
    };
  };
}
