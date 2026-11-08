{
  den.aspects.desktop.plasma = {
    nixos = {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
      services.desktopManager.plasma6.enable = true;
      environment.sessionVariables.ELECTRON_OZONE_PLATFORM_HINT = "x11";
    };
    persist.directories = [ "/var/lib/sddm" ];
  };
}
