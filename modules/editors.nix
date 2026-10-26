{...}:
 {
  flake.nixosModules.editors = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      vscode
      vscodium
      kdePackages.kate
    ];
  };
}
