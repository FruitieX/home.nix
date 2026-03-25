{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      mkHome =
        {
          system,
          username ? "rasse",
          homeDirectory ? null,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [
            ./home.nix
          ] ++ nixpkgs.lib.optionals (username != "rasse" || homeDirectory != null) [
            {
              home.username = username;
              home.homeDirectory = homeDirectory;
            }
          ];
        };
    in
    {
      homeConfigurations = {
        # Bare metal macOS (arm64)
        "rasse@darwin" = mkHome { system = "aarch64-darwin"; };

        # Bare metal Linux
        "rasse@linux" = mkHome { system = "x86_64-linux"; };
        "rasse@linux-arm" = mkHome { system = "aarch64-linux"; };

        # Devcontainers (user is "vscode")
        "vscode@devcontainer" = mkHome {
          system = "aarch64-linux";
          username = "vscode";
          homeDirectory = "/home/vscode";
        };
        "vscode@devcontainer-x86" = mkHome {
          system = "x86_64-linux";
          username = "vscode";
          homeDirectory = "/home/vscode";
        };
      };
    };
}
