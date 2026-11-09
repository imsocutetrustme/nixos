{ den, ... }:
{
  den.aspects.roles.apps.includes = with den.aspects; [
    apps.zen
    apps.helium
    apps.chat
    apps.notes
    apps.waydroid
  ];
}
