{ inputs, ... }:
{
  flake-file.inputs.disko = {
    url = "github:nix-community/disko";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.storage.disko.nixos = {
    imports = [ inputs.disko.nixosModules.disko ];

    disko.devices.disk.main = {
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          BIOS = {
            priority = 1;
            size = "8M";
            type = "EF02";
          };

          BOOT = {
            priority = 2;
            size = "2G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "fmask=0022" "dmask=0022" ];
            };
          };

          swap = {
            priority = 3;
            size = "8G";
            type = "8200";
            content.type = "swap";
          };

          btrfs = {
            priority = 4;
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" "-L" "nixos" ];

              subvolumes = {
                "/@root" = {
                  mountpoint = "/";
                  mountOptions = [ "compress=zstd:3" "noatime" ];
                };

                "/@nix" = {
                  mountpoint = "/nix";
                  mountOptions = [ "compress=zstd:3" "noatime" ];
                };

                "/@persist" = {
                  mountpoint = "/persist";
                  mountOptions = [ "compress=zstd:3" "noatime" ];
                };

                "/@home" = {
                  mountpoint = "/home";
                  mountOptions = [ "compress=zstd:3" "noatime" ];
                };

                "/@snapshots" = {
                  mountpoint = "/.snapshots";
                  mountOptions = [ "compress=zstd:3" "noatime" ];
                };
              };
            };
          };
        };
      };
    };
  };
}
