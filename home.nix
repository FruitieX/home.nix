{ pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "orre";
  home.homeDirectory = "/home/orre";
  nixpkgs.config.allowUnfree = true;
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.05";

  home.packages =
    with pkgs;
    [
      (uutils-coreutils.override { prefix = ""; })
      less # Non busybox version of less needed by delta

      # Utilities
      fd
      skim

      unzip
      ncdu
      jc
      xclip
      bottom
      jless
      navi
      tealdeer
      fend
      bandwhich
      gnused
      gawk

      ripgrep
      igrep

      dust
      dua

      # Git
      gitAndTools.gh
      pre-commit

      # Programming
      nodejs_latest
      nodePackages.pnpm
      #cargo
      tokei
      jq
      xh

      # Needed by Nix LSP
      nil
      nixd
    ]
    # Linux only
    ++ (
      if pkgs.stdenv.isLinux then
        [
          strace
          binutils
        ]
      else
        [ ]
    );

  programs = {
    neovim = (import ./neovim.nix { inherit pkgs; });
    git = (import ./git.nix { inherit pkgs; });
    zsh = (import ./zsh.nix { inherit pkgs; });
    starship = (import ./starship.nix { inherit pkgs; });
    direnv = (import ./direnv.nix { inherit pkgs; });
    lsd = (import ./lsd.nix { inherit pkgs; });
    htop = (import ./htop.nix { inherit pkgs; });
    btop = (import ./btop.nix { inherit pkgs; });
    nushell = (import ./nushell.nix { inherit pkgs; });
    zoxide = (import ./zoxide.nix { inherit pkgs; });
    carapace = (import ./carapace.nix { inherit pkgs; });
    atuin = (import ./atuin.nix { inherit pkgs; });
    gitui = (import ./gitui.nix { inherit pkgs; });
    wezterm = (import ./wezterm.nix { inherit pkgs; });
    zellij = (import ./zellij.nix { inherit pkgs; });
  };
}
