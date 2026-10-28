{...}:
 {
  flake.nixosModules.packages = { pkgs, inputs, ... }: {

    services.v2raya.enable = true;
    services.resolved.enable = true;

    programs.throne = {
      enable = true;
      tunMode.enable = true;
    };


    programs.steam = {
     enable = true;
     extraCompatPackages = [ pkgs.proton-ge-bin ];
    };

    programs.gamemode.enable = true;

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    environment.systemPackages = [
     pkgs.v2ray
     pkgs.v2rayn
     pkgs.v2raya
     pkgs.v2ray-geoip
     pkgs.sing-box
     pkgs.xray
     pkgs.rufin
     pkgs.fetch
     pkgs.discord
     inputs.pyroclear.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
