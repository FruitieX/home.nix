
{ pkgs, ... }:

{
  enable = true;

  extraConfig = ''
    carapace _carapace
  '';
}