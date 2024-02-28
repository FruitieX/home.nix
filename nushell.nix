
{ pkgs, ... }:

{
  enable = true;

  extraConfig = ''
    $env.config = ($env.config | upsert show_banner false)
    $env.config = ($env.config | upsert edit_mode vi)

    alias da = direnv allow
    alias g = git
    alias c = code

    $env.EDITOR = nvim
    $env.LS_COLORS = (${pkgs.vivid}/bin/vivid generate nord | str trim)
  '';
}
