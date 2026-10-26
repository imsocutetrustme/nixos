{...}:
 {
  flake.nixosModules.hardware = {
    imports = [ ./_hardware-configuration.nix ];
    boot.kernelParams = [ "radeon.dpm=0" ];
  };
}
