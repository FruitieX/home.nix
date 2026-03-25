{ pkgs, homeDirectory, ... }:

{
  enable = true;
  enableZshIntegration = true;
  extraConfig = ''
    local config = wezterm.config_builder()

    config.enable_tab_bar = false
    config.color_scheme = 'Ayu Dark (Gogh)'

    config.font = wezterm.font 'FiraCode Nerd Font'
    config.default_prog = { '${homeDirectory}/.nix-profile/bin/zsh', '-l' }

    return config
  '';
}
