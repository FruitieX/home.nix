{ pkgs, ... }:

{
  enable = true;
  enableZshIntegration = true;
  extraConfig = ''
    local config = wezterm.config_builder()

    config.enable_tab_bar = false
    config.color_scheme = 'Ayu Dark (Gogh)'

    config.font = wezterm.font 'FiraCode Nerd Font'
    config.default_prog = { '${
      if pkgs.stdenv.isDarwin then "/Users/rasse" else "/home/rasse"
    }/.nix-profile/bin/zsh', '-l' }

    return config
  '';
}
