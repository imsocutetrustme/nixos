{
  den.aspects.core.networking = {
    nixos = {
      networking.networkmanager.enable = true;
      networking.nftables.enable = true;
      networking.firewall.checkReversePath = "loose";
      time.timeZone = "Asia/Tehran";
      i18n.defaultLocale = "en_US.UTF-8";
    };
    persist.directories = [
      "/etc/NetworkManager/system-connections"
      "/var/lib/NetworkManager"
    ];
  };
}
