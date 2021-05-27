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

    # Launch in tmux session if we're not already in one
    if [[ -z $TMUX ]]; then
      exec tmux new-session -t 0 \; set-option destroy-unattached
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
    export PATH="$HOME/.cargo/bin:$PATH"
  '';

  sessionVariables = {
    # Suppress direnv logs
    DIRENV_LOG_FORMAT = "";

    # Don't use nano
    EDITOR = "nvim";
  };

  plugins = [
    {
      name = "fast-syntax-highlighting";
      src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
    }
  ];
}