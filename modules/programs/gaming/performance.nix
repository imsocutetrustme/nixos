{
  den.aspects.gaming.performance = {
    nixos = {
      programs.gamescope = {
        enable = true;
        capSysNice = true;
      };
      programs.gamemode.enable = true;
    };

    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [ mangohud goverlay ];
    };
  };
}
