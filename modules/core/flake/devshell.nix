{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
       nixd
       nil
       nixfmt
       statix
       deadnix
       sops
       age
       ssh-to-age
       git
      ];
    };
  };
}
