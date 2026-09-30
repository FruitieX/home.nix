{ pkgs, herdr, ... }:

{
  home.packages = [ herdr.packages.${pkgs.stdenv.hostPlatform.system}.default ];
}
