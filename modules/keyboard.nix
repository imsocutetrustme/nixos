{...}:
 {
  flake.nixosModules.keyboard = {
    services.xserver.xkb = {
    layout = "us,ir";
    options = "grp:alt_shift_toggle";
    };
  };
}
