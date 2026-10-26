{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # --- BOOTLOADER---
  boot.loader.limine = {
    enable = true;
    biosSupport = true;
    biosDevice = "/dev/sda";
  };

  # Kernel setup
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [ "radeon.dpm=0" ];

  # --- NETWORKING & LOCALIZATION ---
  networking.hostName = "nixosBTW";
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Tehran";
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable Nix Command & Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # --- GRAPHICS & DESKTOP---
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  #environment.sessionVariables.NIXOS_OZONE_WL = "1";
  services.desktopManager.plasma6.enable = true;

  # Keyboard Layout
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Printing Support
  services.printing.enable = true;

  # --- AUDIO---
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # --- USER & SHELL CONFIGURATION ---
  users.users."ava" = {
    isNormalUser = true;
    description = "Ava";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  # --- PROXY CLIENT ---
  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };

  # --- SYSTEM INTEGRATIONS & QoL ---
  # Un-breaks precompiled binaries downloaded outside Nix
  programs.nix-ld.enable = true;

  # Flatpak GUI package manager support
  services.flatpak.enable = true;

  # Auto-load shell environments when entering directories
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Enable proprietary software (Steam, Discord, drivers, etc.)
  nixpkgs.config.allowUnfree = true;

  # --- SYSTEM PACKAGES ---
  environment.systemPackages = with pkgs; [
    # Core Apps & Utilities
    fastfetch
    neovim
    git
    micro
    foot
    alacritty
    kitty
    wget
    vscode
    vscodium
    telegram-desktop
    firefox
    kdePackages.kate

    # NixOS QoL, GUI Helpers & Error Tools
    nh                   # Modern NixOS rebuild helper (`nh os switch`)
    nix-output-monitor   # Animated progress and error tree during builds
    nvd                  # Version diff tool after updates
    comma                # Run uninstalled programs instantly (`, cowsay hi`)

    # Code formatting & Language Servers
    nixfmt-rfc-style     # Standard Nix code formatter
    nixd                 # Nix Language Server for auto-completion in editors
    nil
    statix               # Nix linter
  ];

  system.stateVersion = "26.05";
}
