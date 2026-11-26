{
  den.aspects.core.rescue-tools.nixos = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [ git wget micro ];
  };
}
