# home.nix
Home Manager configuration files

## Installation

- Install the [Nix package manager](https://nixos.org/download.html#nix-quick-install)
- Clone this repo to `~/.config/home-manager` by running:

  ```
  nix-shell -p git --command "git clone https://github.com/FruitieX/home.nix.git $HOME/.config/home-manager"
  ```

- Edit `home.nix`, change at least `home.homeDirectory` to match yours.

- Install [Home Manager](https://github.com/nix-community/home-manager#installation)
- Run `zsh` to try the config in action. Make your terminal run `zellij
  attach -c main` to automatically open zsh in a zellij session.

  - For example (WSL): "Command line" in Windows Terminal profile settings:
    
    ```
    wsl.exe -d Ubuntu -e bash -lc "zellij attach -c main"
    ```
  
  - On macOS you can run `wezterm` 
