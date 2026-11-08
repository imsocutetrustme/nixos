{ inputs, ... }:
{
  flake-file.inputs.nixvim = {
    url = "github:nix-community/nixvim";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.dev.nixvim.homeManager = {
    imports = [ inputs.nixvim.homeModules.nixvim ];
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      plugins.lsp = {
        enable = true;
        servers.nixd.enable = true;
      };
    };
  };
}
