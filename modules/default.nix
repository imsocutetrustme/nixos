{ self, inputs, ... }: {
  flake.nixosConfigurations.nixosBTW = inputs.nixpkgs.lib.nixosSystem {
    modules = (with self.nixosModules; [
      hardware
      boot
      base
      user
      shell
      audio
      desktop
      keyboard
      printing
      editors
      packages
      flakeInputs
    ]) ++ [
      { networking.hostName = "nixosBTW"; }
    ];
  };
}
