{ den, ... }:
{
  den.aspects.roles.tools.includes = with den.aspects; [
    nix.tools
    nix.lsp
    dev.git
    dev.nixvim
    dev.vscode
    dev.zed
    dev.toolchains
    terminal.alacritty
    terminal.kitty
    terminal.fetch
    terminal.toys
  ];
}
