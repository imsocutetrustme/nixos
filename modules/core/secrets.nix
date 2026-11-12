{ inputs, ... }:
{
  flake-file.inputs.sops-nix = {
    url = "github:Mic92/sops-nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.core.secrets.nixos = {
    imports = [ inputs.sops-nix.nixosModules.sops ];
    sops = {
      defaultSopsFile = ../../secrets/secrets.yaml;
      age.keyFile = "/var/lib/sops-nix/key.txt";
      secrets.test-secret = { };
      secrets.ava-password.neededForUsers = true;
    };
  };
}
