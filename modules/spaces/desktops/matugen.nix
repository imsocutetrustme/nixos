{
  den.aspects.desktop.matugen.homeManager = { pkgs, ... }: {
    home.packages = [ pkgs.matugen ];
    xdg.configFile."matugen/config.toml".source = ../../assets/matugen/config.toml;
    xdg.configFile."matugen/templates".source = ../../assets/matugen/templates;
  };
}
