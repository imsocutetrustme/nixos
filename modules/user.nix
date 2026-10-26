{...}:{
  flake.nixosModules.user = { pkgs, ... }: {
  users.users."ava" = {
      isNormalUser = true;
      description = "Ava";
      extraGroups = [ "wheel" "audio" "video" "networkmanager" ];
      shell = pkgs.fish;
      };
  };
  }
