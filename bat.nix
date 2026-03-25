{ ... }:

{
  enable = true;
  config = {
    theme = "Catppuccin Mocha";
  };
  themes = {
    "Catppuccin Mocha" = {
      src = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/bat/main/themes/Catppuccin%20Mocha.tmTheme";
        name = "Catppuccin-Mocha.tmTheme";
        sha256 = "0xxashmrrj81y99ia4hvcpmplkzr1rlpgh4idf9inc7bikq6cm9r";
      };
    };
  };
}
