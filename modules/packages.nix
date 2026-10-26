{...}:
 {
  flake.nixosModules.packages = { pkgs, inputs, ... }: {
      environment.systemPackages = [
    pkgs.v2rayn
    pkgs.sing-box
    pkgs.xray
    pkgs.rufin
    pkgs.fetch
    inputs.pyroclear.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
  };
}
