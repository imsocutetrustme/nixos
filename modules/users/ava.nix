{ den, ... }:
{
  den.aspects.ava = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      den.batteries.host-aspects
      (den.batteries.user-shell "fish")
    ];
    provides.to-hosts.nixos = { pkgs, ... }: { };
  };
}
