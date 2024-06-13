
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
  '';

  extraEnv = ''
    $env.EDITOR = nvim
    $env.LS_COLORS = (${pkgs.vivid}/bin/vivid generate nord | str trim)
    $env.CARGO_HOME = ($env.HOME | path join .cargo)
    $env.PATH = (
      $env.PATH | split row (char esep)
        | append /usr/local/bin
        | append ($env.CARGO_HOME | path join bin)
        | append ($env.HOME | path join .local bin)
        | uniq # filter so the paths are unique
    )
  '';
}
