{ den, ... }:
{
  den.aspects.storage.snapshots.nixos = {

    systemd.services."btrbk-persistent-data" = {
     requires = [ "btrfs-pool.mount" ];
     after = [ "btrfs-pool.mount" ];
    };

    # Mount the Btrfs top-level filesystem for snapshot management.
    fileSystems."/btrfs-pool" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = [
        "subvolid=5"
        "noatime"
      ];
    };

    # Ensure the mountpoint exists.
    systemd.tmpfiles.rules = [
      "d /btrfs-pool 0755 root root -"
    ];

    # Scheduled local snapshots.
    services.btrbk.instances."persistent-data" = {
      onCalendar = "daily";

      settings = {
        snapshot_preserve_min = "7d";
        snapshot_preserve = "7d 4w 6m";

        volume."/btrfs-pool" = {
          snapshot_dir = "@snapshots";

          subvolume = {
            "@home" = { };
            "@persist" = { };
          };
        };
      };
    };
  };
}
