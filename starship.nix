{ pkgs, ... }:

{
  enable = true;
  enableZshIntegration = true;
  settings = {
    aws = {
      disabled = true;
    };
  };
}
