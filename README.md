# home.nix

Home Manager configuration files

## Installation

Clone this repo to `~/.config/home-manager` and run `install.sh`:

```sh
git clone https://github.com/FruitieX/home.nix.git $HOME/.config/home-manager
~/.config/home-manager/install.sh
```

The install script will:

1. Install Nix if not already present
2. Detect your platform and username automatically
3. Install and activate the Home Manager configuration

To apply changes after editing config files, run `./install.sh` again.

## Herdr

Herdr is installed through Home Manager from its upstream flake, pinned to
stable release `v0.9.3` rather than the older Nixpkgs package. To upgrade, change
the `herdr.url` release tag in `flake.nix`, then run:

```sh
nix flake update herdr
home-manager switch --flake .#rasse
```

Launch it with `herdr`. Nix manages updates; use Home Manager to upgrade it.

## Usage

Run `zsh` to try the config in action. Make your terminal run `zellij
attach -c main` to automatically open zsh in a zellij session.

- For example (WSL): "Command line" in Windows Terminal profile settings:

  ```
  wsl.exe -d Ubuntu -e bash -lc "zellij attach -c main"
  ```

- On macOS you can run `wezterm`

- In VSCode dev containers, set in your user settings.json:

  ```
  "dotfiles.repository": "FruitieX/home.nix",
  "terminal.integrated.defaultProfile.linux": "zsh",
  ```
