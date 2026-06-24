{ pkgs, ... }:

let
  moonVersion = "2.3.4";
  moonSources = {
    aarch64-darwin = {
      platform = "aarch64-apple-darwin";
      hash = "sha256-4CirPXVwvsSng6OT1P74bemd2omHQomQB7mYNJ7VRTo=";
    };
    aarch64-linux = {
      platform = "aarch64-unknown-linux-gnu";
      hash = "sha256-H4gQdvRVoe/7I9/obJK3TCmu3rZba0E1rFDv0U0gabk=";
    };
    x86_64-darwin = {
      platform = "x86_64-apple-darwin";
      hash = "sha256-aWblEyXlAjIAT/zRFX5gTtuNK+uLhMl01565ah3v3jc=";
    };
    x86_64-linux = {
      platform = "x86_64-unknown-linux-gnu";
      hash = "sha256-kv3SXTnsc/tmUEaSyq98oNnCl2pvoQB6/HtAIttG1GM=";
    };
  };
  moonSource =
    moonSources.${pkgs.stdenv.hostPlatform.system}
      or (throw "moon ${moonVersion} is not packaged for ${pkgs.stdenv.hostPlatform.system}");
  moon = pkgs.stdenvNoCC.mkDerivation {
    pname = "moon";
    version = moonVersion;

    src = pkgs.fetchurl {
      url = "https://github.com/moonrepo/moon/releases/download/v${moonVersion}/moon_cli-${moonSource.platform}.tar.xz";
      inherit (moonSource) hash;
    };

    installPhase = ''
      runHook preInstall

      install -Dm755 moon "$out/bin/moon"
      install -Dm755 moonx "$out/bin/moonx"

      runHook postInstall
    '';

    meta = {
      description = "Build system and monorepo management tool for the web ecosystem";
      homepage = "https://moonrepo.dev";
      license = pkgs.lib.licenses.mit;
      mainProgram = "moon";
      platforms = builtins.attrNames moonSources;
    };
  };
in
{
  home.packages = [
    moon
  ];
}
