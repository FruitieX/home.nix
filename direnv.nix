{ pkgs, ... }:

{
  enable = true;
  nix-direnv = { enable = true; };
  enableZshIntegration = true;
}