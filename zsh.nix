{ pkgs, ... }:

{
  enable = true;

  autosuggestion.enable = true;
  enableVteIntegration = true;
  completionInit = "autoload -U compinit && compinit -u";

  envExtra = ''
    skip_global_compinit=1

    # Custom binaries and package manager paths
    export PATH="$HOME/.local/bin:$HOME/.npm-packages/bin:$HOME/.yarn/bin:$HOME/.opencode/bin:$PATH"

    # Allow running project-local node binaries without npx
    export PATH="./node_modules/.bin:$PATH"

    # Rust toolchain
    . "$HOME/.cargo/env"
  ''
  + (if pkgs.stdenv.isDarwin then ''
    # Homebrew (macOS only)
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '' else "");

  shellAliases = {
    da = "direnv allow";
    g = "git";
    c = "code";
    zj = "zellij attach -c \"\${PWD:t}\"";
    hms = "~/.config/home-manager/install.sh";
  };

  initContent = pkgs.lib.mkOrder 1 ''
    # 'jj' enters normal mode
    bindkey -M viins 'jj' vi-cmd-mode

    if [ -f ~/.aliases ]; then
      . ~/.aliases
    fi
  '';

  sessionVariables = {
    # Suppress direnv logs
    DIRENV_LOG_FORMAT = "";

    # Don't use nano
    EDITOR = "vim";
    GIT_EDITOR = "vim";

    # 'jj' enters normal mode
    ZVM_VI_INSERT_ESCAPE_BINDKEY = "jj";
  };

  plugins = [
    {
      name = "fast-syntax-highlighting";
      src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
    }
    # {
    #   name = "zsh-vi-mode";
    #   src = builtins.fetchGit {
    #     url = "https://github.com/jeffreytse/zsh-vi-mode";
    #     rev = "9178e6bea2c8b4f7e998e59ef755820e761610c7";
    #   };
    # }
  ];
}
