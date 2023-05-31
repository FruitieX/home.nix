
{ pkgs, ... }:

{
  enable = true;

  extraConfig = ''
    let-env config = {
      hooks: {
        pre_prompt: [{ ||
          let direnv = (direnv export json | from json)
          let direnv = if ($direnv | length) == 1 { $direnv } else { {} }
          $direnv | load-env
        }]
      }
    }

    let carapace_completer = {|spans| 
      carapace $spans.0 nushell $spans | from json
    }

    let-env config = {
      completions: {
        external: {
          enable: true
          completer: $carapace_completer
        }
      }
    }
  '';
}