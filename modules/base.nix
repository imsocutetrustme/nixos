{
  flake.nixosModules.base = { pkgs, ... }: {
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    networking.networkmanager.enable = true;
    time.timeZone = "Asia/Tehran";
    i18n.defaultLocale = "en_US.UTF-8";

    networking.firewall.checkReversePath = "loose";
    networking.nftables.enable = true;

    environment.systemPackages = with pkgs; [
      git wget fastfetch firefox telegram-desktop
      nh nix-output-monitor nvd comma
    ];

    system.stateVersion = "26.05";
  };
}
