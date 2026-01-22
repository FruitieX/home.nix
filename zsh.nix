{ pkgs, ... }:

{
  enable = true;

  autosuggestion.enable = true;
  enableVteIntegration = true;

  shellAliases = {
    da = "direnv allow";
    g = "git";
    c = "code";
  };

  initContent = pkgs.lib.mkOrder 1 ''
    # Launch zellij if stdout/stdin/stderr are connected to a terminal
    if [[ -z "$ZELLIJ" ]] && [[ -t 0 ]] && [[ -t 1 ]] && [[ -t 2 ]]; then
      # Use current directory name as session name
      local session_name=''${1:-''${PWD:t}}
      zellij attach -c "$session_name" && exit
    fi

    # 'jj' enters normal mode
    bindkey -M viins 'jj' vi-cmd-mode

    if [ -f ~/.aliases ]; then
      . ~/.aliases
    fi
  '';

  profileExtra = ''
    # Adds global npm & yarn packages to $PATH
    export PATH="$HOME/.npm-packages/bin:$HOME/.yarn/bin:$PATH";

    # Adds local npm & yarn packages to $PATH
    export PATH="./node_modules/.bin:$PATH"

    # Adds pip packages to $PATH
    export PATH="$HOME/.local/bin:$PATH"

    # Adds cargo packages to $PATH
    . "$HOME/.cargo/env"

    # Adds opencode to $PATH
    export PATH="$HOME/.opencode/bin:$PATH"
  ''
  + (
    if pkgs.stdenv.isDarwin then
      ''
        eval "$(/opt/homebrew/bin/brew shellenv)"
      ''
    else
      ''
        # export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0
      ''
  );

  sessionVariables = {
    # Suppress direnv logs
    DIRENV_LOG_FORMAT = "";

    # Don't use nano
    EDITOR = "vim";

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
