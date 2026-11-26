{
  den.aspects.gaming.capture = {
    nixos.programs.gpu-screen-recorder.enable = true;
    homeManager = { pkgs, ... }: {
      home.packages = [ pkgs.gpu-screen-recorder-gtk ];
    };
  };
}
