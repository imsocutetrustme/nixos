
{ inputs, ... }:
{
  flake-file.inputs.fetch.url = "github:areofyl/fetch";

  den.aspects.terminal.fetch.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      fastfetch
      hyfetch
      inputs.fetch.packages.${pkgs.system}.default
    ];
  };
}
