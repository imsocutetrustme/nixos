{ inputs, config, ... }:
let
  nixosMods = config.flake.modules.nixos;
in
{
  flake.nixosConfigurations.nixosBTW = inputs.nixpkgs.lib.nixosSystem {
    modules = [ nixosMods.pc ];
  };

  flake.nixosModules.pc = { pkgs, ... }: {
    imports = [
      ./_hardware-configuration.nix
      nixosMods.base
      nixosMods.shell
    ];

    networking.hostName = "nixosBTW";

    boot.loader.limine = {
      enable = true;
      biosSupport = true;
      biosDevice = "/dev/sda";
    };
    boot.kernelPackages = pkgs.linuxPackages_latest;
    boot.kernelParams = [ "radeon.dpm=0" ];

    # Desktop#######
    #services.xserver.enable = true;
    #services.displayManager.sddm = {
    #  enable = true;
    #  wayland.enable = true;
    #};
    #services.desktopManager.plasma6.enable = true;

    #keyboard
    #services.xserver.xkb = { layout = "us"; variant = ""; };
    #printing
    #services.printing.enable = true;

    # Audio########
    #services.pulseaudio.enable = false;
    #security.rtkit.enable = true;
    #services.pipewire = {
    #  enable = true;
    #  alsa.enable = true;
    #  alsa.support32Bit = true;
    #  pulse.enable = true;
    #};

   # environment.systemPackages = with pkgs; [
   #   vscode vscodium kdePackages.kate
   # ];
  };
}
