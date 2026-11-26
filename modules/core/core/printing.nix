{
  den.aspects.core.printing = {
    nixos = { pkgs, ... }:
      let
        p1006Firmware = pkgs.stdenvNoCC.mkDerivation {
          pname = "hp-laserjet-p1006-firmware";
          version = "1.0";

          src = pkgs.fetchurl {
            url = "https://www.quirinux.org/printers/sihpP1006.tar.gz";
            hash = "sha256-ue/mkm/EysV4sYte+K2rE+h8gKJUMDCREOP2Gs5bz48=";
          };

          nativeBuildInputs = [
            pkgs.gnutar
            pkgs.foo2zjs
          ];

          dontUnpack = true;

          installPhase = ''
            mkdir -p "$TMPDIR/firmware" "$out/lib/firmware"
            tar -xzf "$src" -C "$TMPDIR/firmware"

            ${pkgs.foo2zjs}/bin/arm2hpdl \
              "$TMPDIR/firmware/sihpP1006.img" \
              > "$out/lib/firmware/sihpP1006.dl"
          '';
        };

        uploadFirmware = pkgs.writeShellScript "hp-p1006-upload-firmware" ''
          set -eu
          echo "Uploading HP LaserJet P1006 firmware"
          cat ${p1006Firmware}/lib/firmware/sihpP1006.dl > /dev/usb/lp0
          echo "HP LaserJet P1006 firmware upload completed"
        '';
      in
      {
        boot.kernelModules = [ "usblp" ];

        services.udev.extraRules = ''
          ACTION=="add", SUBSYSTEM=="usbmisc", KERNEL=="lp[0-9]*", ATTRS{idVendor}=="03f0", ATTRS{idProduct}=="3e17", ATTRS{serial}=="AC1G2YB", TAG+="systemd", ENV{SYSTEMD_WANTS}+="hp-p1006-firmware.service"
        '';

        systemd.services.hp-p1006-firmware = {
          description = "Upload firmware to HP LaserJet P1006";

          serviceConfig = {
            Type = "oneshot";
            ExecStart = uploadFirmware;
            };
        };

        services.printing = {
          enable = true;
          drivers = with pkgs; [
            foo2zjs
            hplip
          ];
        };
      };

    persist.directories = [ "/var/lib/cups" ];
  };
}
