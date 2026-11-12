{ den, ... }:
{
  den.aspects.roles.gaming.includes = with den.aspects; [
    gaming.steam
    gaming.launchers
    gaming.performance
    gaming.capture
  ];
}
