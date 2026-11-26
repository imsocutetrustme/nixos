{ den, ... }:
{
  den.aspects.storage.rollback.nixos = { pkgs, utils, ... }: {
    boot.initrd.supportedFilesystems = [ "btrfs" ];

    boot.initrd.systemd.services.rollback-root = {
      description = "Restore Btrfs root from its blank snapshot";

      wantedBy = [ "initrd.target" ];

      requires = [
        "${utils.escapeSystemdPath "/dev/disk/by-label/nixos"}.device"
      ];

      after = [
        "${utils.escapeSystemdPath "/dev/disk/by-label/nixos"}.device"
        "local-fs-pre.target"
      ];

      before = [ "sysroot.mount" ];

      unitConfig.DefaultDependencies = false;
      serviceConfig.Type = "oneshot";

      script = ''
        set -eu

        BTRFS=${pkgs.btrfs-progs}/bin/btrfs

        mkdir -p /btrfs-tmp

        ${pkgs.util-linux}/bin/mount \
          -t btrfs \
          -o subvolid=5 \
          /dev/disk/by-label/nixos \
          /btrfs-tmp

        trap '${pkgs.util-linux}/bin/umount /btrfs-tmp' EXIT

        root=/btrfs-tmp/@root
        baseline=/btrfs-tmp/@root-blank
        staging=/btrfs-tmp/@root-new

        path_exists() {
          [ -e "$1" ] || [ -L "$1" ]
        }

        is_subvolume() {
          "$BTRFS" subvolume show "$1" >/dev/null 2>&1
        }

        assert_subvolume() {
          check_path="$1"
          check_label="$2"

          if [ -L "$check_path" ] || \
             [ ! -d "$check_path" ] || \
             ! is_subvolume "$check_path"; then
            echo "$check_label is missing or is not a Btrfs subvolume: $check_path" >&2
            exit 1
          fi
        }

        assert_no_nested_subvolumes() {
          check_path="$1"
          check_label="$2"

          nested="$("$BTRFS" subvolume list -o "$check_path")"

          if [ -n "$nested" ]; then
            echo "Refusing rollback: nested subvolumes exist in $check_label." >&2
            exit 1
          fi
        }

        # Validate the read-only root baseline.
        assert_subvolume "$baseline" "Root baseline"

        baseline_ro="$("$BTRFS" property get -ts "$baseline" ro)"

        if [ "$baseline_ro" != "ro=true" ]; then
          echo "Root baseline is not read-only." >&2
          exit 1
        fi

        assert_no_nested_subvolumes "$baseline" "root baseline"

        # Recover an interrupted previous restoration.
        recovered=0

        if path_exists "$staging"; then
          assert_subvolume "$staging" "Staging path"
          assert_no_nested_subvolumes "$staging" "staging snapshot"

          if path_exists "$root"; then
            assert_subvolume "$root" "Existing root"
            assert_no_nested_subvolumes "$root" "existing root"

            # Staging is obsolete because the old root still exists.
            "$BTRFS" subvolume delete "$staging"
          else
            # The old root was already deleted: promote the staged snapshot.
            staging_ro="$("$BTRFS" property get -ts "$staging" ro)"

            if [ "$staging_ro" != "ro=false" ]; then
              echo "Staging snapshot is not writable." >&2
              exit 1
            fi

            mv "$staging" "$root"
            recovered=1
          fi
        fi

        # Do not replace a root already recovered from staging.
        if [ "$recovered" -eq 0 ]; then

          if path_exists "$root"; then
            assert_subvolume "$root" "Existing root"
            assert_no_nested_subvolumes "$root" "existing root"
          fi

          # Create the new root before deleting the existing one.
          "$BTRFS" subvolume snapshot \
            "$baseline" \
            "$staging"

          assert_subvolume "$staging" "New staging snapshot"
          assert_no_nested_subvolumes "$staging" "new staging snapshot"

          staging_ro="$("$BTRFS" property get -ts "$staging" ro)"

          if [ "$staging_ro" != "ro=false" ]; then
            echo "New staging snapshot is not writable." >&2
            exit 1
          fi

          if path_exists "$root"; then
            "$BTRFS" subvolume delete "$root"
          fi

          mv "$staging" "$root"
        fi

        # Final validation before sysroot.mount.
        assert_subvolume "$root" "Restored root"
        assert_no_nested_subvolumes "$root" "restored root"

        root_ro="$("$BTRFS" property get -ts "$root" ro)"

        if [ "$root_ro" != "ro=false" ]; then
          echo "Restored root is not writable." >&2
          exit 1
        fi

        if path_exists "$staging"; then
          echo "Staging path remains after rollback." >&2
          exit 1
        fi
      '';
    };
  };
}
