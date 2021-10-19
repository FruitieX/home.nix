{ pkgs, ... }:

{
  enable = true;

  enableAutosuggestions = true;
  enableVteIntegration = true;
  dirHashes = {
    tm = "$HOME/tofuman";
  };

  shellAliases = {
    # da comrade
    da = "direnv allow";

    g = "git";
  };

  initExtra = ''
    mkdir -p $HOME/.tmux
    export TMUX_TMPDIR=$HOME/.tmux
    export DISPLAY=$(grep -m 1 nameserver /etc/resolv.conf | awk '{print $2}'):0

    # Launch in tmux session if we're not already in one
    if [[ -z $TMUX ]]; then
      exec tmux new-session -t 0 \; set-option destroy-unattached
    fi

    # 'jj' enters normal mode
    bindkey -M viins 'jj' vi-cmd-mode
  '';

  profileExtra = ''
    # Adds global npm & yarn packages to $PATH
    export PATH="$HOME/.npm-packages/bin:$HOME/.yarn/bin:$PATH";

    # Adds local npm & yarn packages to $PATH
    export PATH="./node_modules/.bin:$PATH"

    # Adds pip packages to $PATH
    export PATH="$HOME/.local/bin:$PATH"

    # Adds cargo packages to $PATH
    export PATH="$HOME/.cargo/bin:$PATH"
  '';

  sessionVariables = {
    # Suppress direnv logs
    DIRENV_LOG_FORMAT = "";

    # Don't use nano
    EDITOR = "nvim";

    # 'jj' enters normal mode
    ZVM_VI_INSERT_ESCAPE_BINDKEY = "jj";
  };

  plugins = [
    {
      name = "fast-syntax-highlighting";
      src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
    }
    {
      name = "zsh-vi-mode";
      src = builtins.fetchGit {
        url = "https://github.com/jeffreytse/zsh-vi-mode";
        rev = "9178e6bea2c8b4f7e998e59ef755820e761610c7";
      };
    }
  ];

  oh-my-zsh = {
    enable = true;
    plugins = [
      "git"
      "npm"
      "docker"
      "command-not-found"
      "ubuntu"
      "z"
      "history-substring-search"
      "rust"
      "cargo"
    ];
  };
}
