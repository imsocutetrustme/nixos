{
  den.aspects.nix.compat.nixos = {
    programs.nix-ld.enable = true;
    services.envfs.enable = true;
  };
}
