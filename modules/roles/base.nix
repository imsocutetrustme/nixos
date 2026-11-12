{ den, ... }:
{
  den.aspects.roles.base.includes = with den.aspects; [
    core.networking
    core.boot
    core.audio
    core.keyboard
    core.printing
    core.proxy
    core.rescue-tools
    core.secrets
    nix.core
    nix.compat
    dev.direnv
    apps.flatpak
  ];
}
