{
  den.aspects.nix.lsp.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
     nixd
     nil
     nixfmt
     statix
     deadnix
    ];
  };
}
