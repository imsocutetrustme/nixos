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
    nix.core
    nix.compat
    dev.direnv
    apps.flatpak
    legacy.packages # TEMP, deleted at the end of Phase 7
  ];
}
