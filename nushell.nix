
{ pkgs, ... }:

{
  enable = true;

  # extraEnv = ''
  #   zoxide init nushell | save -f ~/.zoxide.nu
  # '';

  extraConfig = ''
    let carapace_completer = {|spans| 
      carapace $spans.0 nushell $spans | from json
    }

    $env.config = {
      show_banner: false,
      edit_mode: vi,

      hooks: {
        pre_prompt: [{ ||
	    if (which direnv | is-empty) {
            return
          }

          direnv export json | from json | default {} | load-env
        }]
      },

      completions: {
        external: {
          enable: true
          completer: $carapace_completer
        }
      }
    }

    alias da = direnv allow
    alias g = git
    alias c = code-insiders

    $env.EDITOR = nvim
  '';
}
