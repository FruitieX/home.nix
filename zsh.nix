{ pkgs, ... }:

{
  enable = true;

  autosuggestion.enable = true;
  enableVteIntegration = true;
  completionInit = ''
    autoload -U compinit && compinit -u

    # Generate from the runtime moon so completion follows the version active
    # in the shell instead of forcing Home Manager to build a moon package.
    if (( $+commands[moon] )); then
      source <(
        {
          moon completions --shell zsh \
            | sed \
                -e "s#'\*::targets -- Targets to \*only\* graph:_default'#'\*::targets -- Targets to *only* graph:_moon_targets'#" \
                -e "s#'::target -- Target of task to \*only\* graph:_default'#'::target -- Target of task to *only* graph:_moon_targets'#" \
                -e "s#':target -- Target of task to display:_default'#':target -- Target of task to display:_moon_targets'#" \
                -e "s#'\*::targets -- List of targets to run:_default'#'\*::targets -- List of targets to run:_moon_targets'#" \
                -e "s#'\*::targets -- Task targets to \*only\* graph:_default'#'\*::targets -- Task targets to *only* graph:_moon_targets'#" \
                -e "s#'\*::targets -- List of explicit task targets to run:_default'#'\*::targets -- List of explicit task targets to run:_moon_targets'#" \
                -e "s#'\*::targets -- List of task targets to execute in the action pipeline:_default'#'\*::targets -- List of task targets to execute in the action pipeline:_moon_targets'#" \
                -e "s#'::target -- Task target to inspect:_default'#'::target -- Task target to inspect:_moon_targets'#" \
                -e "s#'::target -- Task target to \*only\* graph:_default'#'::target -- Task target to *only* graph:_moon_targets'#"
          cat <<'EOF'

_moon_targets() {
    local -a targets
    local task_json

    if ! (( $+commands[moon] && $+commands[jq] )); then
        return 1
    fi

    # Moon 1 uses --json; Moon 2 query commands emit JSON by default.
    task_json="$(moon query tasks --json 2>/dev/null)"
    if [[ -z "$task_json" || "$task_json" != \{* ]]; then
        task_json="$(moon query tasks 2>/dev/null)"
    fi

    targets=(
        "''${(@f)$(jq -r '.tasks | [to_entries[] | .value | to_entries[] | .value | (.target, ":" + .id)] | unique[]' <<< "$task_json" 2>/dev/null)}"
    )

    (( $#targets )) || return 1
    compadd "$@" -a targets
}
EOF
        }
      )
    fi
  '';

  envExtra = ''
    # Source Nix environment (the installer only added this to bashrc, not zshenv)
    if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
      . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
    fi

    skip_global_compinit=1

    # Custom binaries and package manager paths
    export PATH="$HOME/.local/bin:$HOME/.local/share/pnpm:$HOME/.npm-packages/bin:$HOME/.yarn/bin:$HOME/.opencode/bin:$PATH"

    # Allow running project-local node binaries without npx
    export PATH="./node_modules/.bin:$PATH"

    export PNPM_HOME="$HOME/.local/share/pnpm"
    export NPM_CONFIG_PREFIX="$HOME/.npm-packages"

    export LITTLE_CODER_PERMISSION_MODE=accept-all

    # Rust toolchain
    if [ -r "$HOME/.cargo/env" ]; then
      . "$HOME/.cargo/env"
    fi
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
