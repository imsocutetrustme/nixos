{
  den.aspects.desktop.fonts.nixos = { pkgs, ... }: {
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
      vazirmatn
    ];
  };
}
