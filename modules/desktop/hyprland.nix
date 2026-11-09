{
  den.aspects.desktop.hyprland = {
    nixos.programs.hyprland.enable = true; # SDDM picks the session up automatically
    homeManager.wayland.windowManager.hyprland = {
      enable = true;
      package = null;
      portalPackage = null;
      settings = {
        "$mod" = "SUPER";
        input = {
          kb_layout = "us,ir";
          kb_options = "grp:alt_shift_toggle";
        };
        bind = [
          "$mod, Return, exec, foot"
          "$mod, Q, killactive"
          "$mod SHIFT, E, exit"
        ];
      };
    };
  };
}
