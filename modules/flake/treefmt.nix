{ inputs, ... }:
{
  flake-file.inputs.treefmt-nix = {
    url = "github:numtide/treefmt-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  imports = [ (inputs.treefmt-nix.flakeModule) ];

  perSystem.treefmt = {
    projectRootFile = "flake.nix";
    programs = {
      nixfmt.enable = true;
      statix.enable = true;
      deadnix.enable = true;
    };
    settings.global.excludes = [ "flake.nix" ];
  };
}
