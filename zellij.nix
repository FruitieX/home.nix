{ pkgs, ... }:

{
  enable = true;
  # enableZshIntegration = true;
  # exitShellOnExit = true;
  settings = {
    simplified_ui = true;
    theme = "catppuccin-mocha";
    default_shell = "${pkgs.zsh}/bin/zsh";
    show_startup_tips = false;
  };
}
