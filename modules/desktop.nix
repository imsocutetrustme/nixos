{...}:{
  flake.nixosModules.desktop = { ... }: {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };

    environment.sessionVariables.ELECTRON_OZONE_PLATFORM_HINT = "x11";

    services.desktopManager.plasma6.enable = true;
  };
  }
