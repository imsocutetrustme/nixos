
{ inputs, ... }:
{
  flake-file.inputs.pyroclear.url = "github:shreyanth-sureshkrishnaa/pyroclear";

  den.aspects.terminal.toys.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      cbonsai
      cmatrix
      cava
      inputs.pyroclear.packages.${pkgs.system}.default
    ];
  };
}
