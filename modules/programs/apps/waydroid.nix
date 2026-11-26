{
  den.aspects.apps.waydroid = {
    nixos = {
      virtualisation.waydroid.enable = true;
      # If the container has no network with nftables on, also trust its bridge:
      # networking.firewall.trustedInterfaces = [ "waydroid0" ];
    };
    persist.directories = [ "/var/lib/waydroid" ];
  };
}
