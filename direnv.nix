{ pkgs, ... }:

{
  enable = true;
  package = pkgs.direnv.overrideAttrs (old: {
    env = (old.env or { }) // { CGO_ENABLED = "1"; };
  });
  nix-direnv = { enable = true; };
}
