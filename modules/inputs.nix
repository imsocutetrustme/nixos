{ inputs, ... }:
{
  flake.nixosModules.flakeInputs = {
    _module.args.inputs = inputs;
  };
}
