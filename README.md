# home.nix
Home Manager configuration files

## Installation

- Install the [Nix package manager](https://nixos.org/download.html#nix-quick-install)
- Clone this repo to `~/.config/nixpkgs` by running:

  ```
  nix-shell -p git --command "git clone https://github.com/FruitieX/home.nix.git $HOME/.config/nixpkgs"
  ```

- Install [Home Manager](https://github.com/nix-community/home-manager#installation)
- Run `zsh` to try the config in action. Make your default shell run zsh or set zsh as default shell to automate this.
  - For example (WSL): "Command line" in Windows Terminal profile settings:
    
    ```
    wsl.exe -d Ubuntu -e bash -lc zsh
    ```
