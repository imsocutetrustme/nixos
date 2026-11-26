{
  den.aspects.core.flatpak = {
    nixos.services.flatpak.enable = true;
    persist.directories = [ "/var/lib/flatpak" ];
  };
}
