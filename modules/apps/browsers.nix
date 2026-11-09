{ inputs, ... }:

{
  flake-file.inputs.zen-browser = {
    url = "github:0xc000022070/zen-browser-flake";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
  };

  flake-file.inputs.helium = {
    url = "github:oxcl/nix-flake-helium-browser";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.apps.zen.homeManager = {
    imports = [inputs.zen-browser.homeModules.beta];

    programs.zen-browser.enable = true;
  };

  den.aspects.apps.helium.homeManager = {
    imports = [inputs.helium.homeModules.default];
    programs.helium.enable = true;
  };
}
