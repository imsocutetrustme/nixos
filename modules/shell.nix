{...}:{
  flake.nixosModules.shell = { pkgs, ... }: {
    programs.fish.enable = true;

    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    services.flatpak.enable = true;
    programs.nix-ld.enable = true;

    environment.systemPackages = with pkgs; [
      neovim micro foot alacritty kitty
      nixfmt-rfc-style nixd nil statix
    ];
  };
}
