{ den, inputs, ... }:
{
  flake-file.inputs.nixvim = {
    url = "github:nix-community/nixvim";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.dev.vscode = {
    includes = [ (den.batteries.unfree [ "vscode" ]) ];

    homeManager = { pkgs, ... }: {
      programs.vscode = {
        enable = true;

        package = pkgs.vscode.override {
          commandLineArgs = "--ozone-platform=x11";
        };
      };
    };
  };

  den.aspects.dev.zed = {
    homeManager.programs.zed-editor = {
      enable = true;

      extensions = [
        "nix"
        "toml"
        "rust"
      ];
    };
  };

  den.aspects.dev.nixvim.homeManager = {
    imports = [ inputs.nixvim.homeModules.nixvim ];
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      plugins.lsp = {
        enable = true;
        servers.nixd.enable = true;
      };
    };
  };
}
