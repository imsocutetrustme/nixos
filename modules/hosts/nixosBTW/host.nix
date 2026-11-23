{ den, ... }:
{
  den.aspects.nixosBTW = {
    includes = with den.aspects.roles; [
      base
      desktop
      tools
      apps
      gaming
      storage
    ];

    nixos = {
      networking.hostName = "nixosBTW";
      home-manager.backupFileExtension = "hm-bak";

      imports = [ ./_hardware-configuration.nix ];

      disko.devices.disk.main.device =
        "/dev/disk/by-id/ata-ST500DM002-1BD142_W2AADHP6";
    };
  };
}
