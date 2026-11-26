{
  den.aspects.desktop.plasma = {
    nixos = {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
      services.desktopManager.plasma6.enable = true;
    };
    persist.directories = [ "/var/lib/sddm" ];
  };
}
