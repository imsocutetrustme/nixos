{
  den.aspects.gaming.launchers.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      umu-launcher
      protonplus
      lutris
      heroic
      faugus-launcher
      bottles
    ];
  };
}
