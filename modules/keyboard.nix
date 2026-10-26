{...}:
 {
  flake.nixosModules.keyboard = {
    services.xserver.xkb = { layout = "us"; variant = ""; };
  };
}
