{ den, ... }:
{
  den.aspects.roles.tools.includes = with den.aspects; [
    nix.tools
    nix.lsp
    dev.git
    dev.nixvim
    dev.vscodium
    dev.vscode
    terminal.foot
    terminal.alacritty
    terminal.kitty
    terminal.fetch
    terminal.toys
  ];
}
