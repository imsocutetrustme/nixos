{
  den.aspects.core.boot.nixos = { pkgs, ... }: {
    boot.loader.limine = {
      enable = true;
      biosSupport = true;
      biosDevice = "/dev/sda";
    };
    services.dbus.implementation = "broker";
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.supportedFilesystems = [ "ntfs" ];
  };
}
