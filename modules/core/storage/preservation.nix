{ den, inputs, ... }:
{
  # Preservation flake input
  flake-file.inputs.preservation = {
    url = "github:nix-community/preservation";
  };

  # Register Den's persistence quirk
  den.quirks.persist.description =
    "System paths that must survive reboot";

  # Main Preservation aspect
  den.aspects.storage.preservation = {
    includes = [
      den.aspects.storage.preservation.collect
    ];

    nixos = {
      imports = [
        inputs.preservation.nixosModules.preservation
      ];

      preservation = {
        enable = true;

        preserveAt."/persist" = {
          directories = [

            {
              directory = "/var/lib/nixos";
              inInitrd = true;
            }

            {
              directory = "/var/lib/sops-nix";
              inInitrd = true;
              mode = "0700";
            }

            "/var/lib/systemd/timers"
            "/var/log"

          ];

          files = [
            {
              file = "/etc/machine-id";
              inInitrd = true;
            }
          ];
        };
      };

      fileSystems."/persist".neededForBoot = true;

      systemd.suppressedSystemUnits = [
        "systemd-machine-id-commit.service"
      ];
    };
  };

  # Collect paths declared by individual Den aspects
  den.aspects.storage.preservation.collect.nixos = { persist, lib, ... }:
    {
      preservation.preserveAt."/persist" = {
        directories = lib.unique (
          lib.concatMap (entry: entry.directories or [ ]) persist
        );

        files = lib.unique (
          lib.concatMap (entry: entry.files or [ ]) persist
        );
      };
    };
}
