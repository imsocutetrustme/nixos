{ den, ... }:
{
  den.aspects.roles.storage.includes = [
    den.aspects.storage.disko
    den.aspects.storage.rollback
    den.aspects.storage.preservation
    den.aspects.storage.snapshots
  ];
}
