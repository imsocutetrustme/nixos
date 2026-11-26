{
  den.aspects.core.boot.nixos = { pkgs, ... }: {
    boot.loader.limine = {
      enable = true;

      efiSupport = false;
      biosSupport = true;

      biosDevice = "/dev/disk/by-id/ata-ST500DM002-1BD142_W2AADHP6";

      partitionIndex = 1;

      maxGenerations = 10;
    };

    services.dbus.implementation = "broker";

    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.supportedFilesystems = [ "ntfs" ];
  };
}
