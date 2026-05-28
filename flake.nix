{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hl = {
      url = "github:pamburus/hl";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, hl, ... }:
    let
      currentUser =
        let
          u = builtins.getEnv "USER";
        in
        if u != "" then u else "rasse";

      currentSystem =
        if builtins ? currentSystem then
          builtins.currentSystem
        else
          "x86_64-linux";

      supportedSystems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];

      mkHome =
        {
          system,
          username ? currentUser,
          homeDirectory ? null,
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = { inherit hl; };
          modules = [
            ./home.nix
            {
              home.username = username;
              home.homeDirectory =
                if homeDirectory != null then
                  homeDirectory
                else if nixpkgs.legacyPackages.${system}.stdenv.isDarwin then
                  "/Users/${username}"
                else
                  "/home/${username}";
            }
          ];
        };

      mkCurrentUserHome = system: {
        ${currentUser} = mkHome { inherit system; };
      };
    in
    {
      legacyPackages = nixpkgs.lib.genAttrs supportedSystems (system: {
        homeConfigurations = mkCurrentUserHome system;
      });

      homeConfigurations = {
        # Bare metal macOS (arm64)
        "darwin" = mkHome { system = "aarch64-darwin"; };

        # Bare metal Linux
        "linux" = mkHome { system = "x86_64-linux"; };
        "linux-arm" = mkHome { system = "aarch64-linux"; };

        # Devcontainers (user is "vscode")
        "devcontainer" = mkHome {
          system = "aarch64-linux";
          username = "vscode";
          homeDirectory = "/home/vscode";
        };
        "devcontainer-x86" = mkHome {
          system = "x86_64-linux";
          username = "vscode";
          homeDirectory = "/home/vscode";
        };
      } // mkCurrentUserHome currentSystem;
    };
}
