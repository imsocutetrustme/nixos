{ den, lib, inputs, ... }:
let
  diagram = inputs.den-diagram.lib;
  render = diagram.renderers { };

  # One pipeline run for the whole flake: every scope, host and user.
  fleetCapture = den.lib.capture.captureFleet { };

  hosts = lib.concatMap builtins.attrValues (builtins.attrValues den.hosts);

  hostViews =
    host:
    let
      g = diagram.projectScope {
        inherit fleetCapture;
        kind = "host";
        inherit (host) name;
        direction = "TD";
      };
    in
    {
      "${host.name}-aspects" = render.toMermaid (diagram.graph.aspectsOnly g);
      "${host.name}-nixos" = render.toMermaid (diagram.graph.classSlice "nixos" g);
    };
in
{
  flake-file.inputs.den-diagram.url = "github:denful/den-diagram";

  flake.diagrams = {
    scope-topology = render.toScopeTopologyMermaid fleetCapture;
  } // lib.mergeAttrsList (map hostViews hosts);
}
