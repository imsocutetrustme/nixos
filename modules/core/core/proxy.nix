{
  den.aspects.core.proxy = {

    nixos = { pkgs, ... }: {

      services.resolved.enable = true;
      programs.throne = {
        enable = true;
        tunMode.enable = true;
      };

      environment.systemPackages = with pkgs; [
      v2rayn
      v2ray
      v2ray-geoip
      sing-box
      xray
      ];
    };
  };
}
