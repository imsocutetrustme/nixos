{
  den.aspects.hardware.gpu.nixos = { pkgs, ... }: {
    hardware.enableRedistributableFirmware = true;
    boot.initrd.kernelModules = [ "radeon" ];

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ libva-vdpau-driver ];
    };

   boot.kernelParams = [ "video=VGA-1:1600x900@60" ];
  };
}
