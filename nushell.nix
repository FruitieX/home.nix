
{ pkgs, ... }:

{
  enable = true;

  extraConfig = ''
    $env.config = ($env.config | upsert show_banner false)
    $env.config = ($env.config | upsert edit_mode vi)

    alias da = direnv allow
    alias g = git
    alias gui = gitui
    alias c = code

    # Maybe these won't be needed one day
    alias ls = lsd
    alias l = ls -l
    alias la = ls -a
    alias lla = ls -la
    alias lt = ls --tree

    $env.EDITOR = nvim
    $env.LS_COLORS = (${pkgs.vivid}/bin/vivid generate nord | str trim)
  '';
}
