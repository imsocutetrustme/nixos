{ ... }:

{
  den.aspects.dev.toolchains.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      # Rust
      rustc
      cargo
      rustfmt
      clippy
      rust-analyzer

      # Python
      python3
      uv
      ruff

      # Go
      go
      gopls
      golangci-lint

      # JavaScript / TypeScript
      nodejs
      pnpm

      # Java
      jdk

      # C / C++
      gcc
      gnumake
      cmake
      ninja
      meson
      pkg-config

      # Lua
      lua
      lua-language-server
      stylua
    ];
  };
}
