{ ... }:

{
  enable = true;

  userEmail = "rasmus@lovegren.fi";
  userName = "Rasmus Lövegren";

  ignores = [
    "target"
    ".vscode"
    ".direnv"
    "*~"
    "*.swp"
  ];

  delta = {
    enable = true;
    options = {
      line-numbers = true;
    };
  };

  extraConfig = {
    push = {
      default = "simple";
    };

    core = {
      autocrlf = "input";
      eol = "lf";
    };

    merge = {
      conflictstyle = "diff3";
    };

    pull = {
      rebase = true;
    };

    diff = {
      compactionHeuristic = true;
    };

    rebase = {
      autoStash = true;
    };

    init = {
      defaultBranch = "main";
    };
  };

  aliases = {
    main = "!git symbolic-ref refs/remotes/origin/HEAD | cut -d'/' -f4";
    remotesh = "remote set-head origin --auto";

    a = "add";
    ap = "add --patch";

    b = "branch";
    bc = "checkout -b";
    bd = "branch --delete";

    c = "commit --verbose";
    ca = "commit --verbose --all";
    co = "checkout";
    com = "! git checkout $(git main)";
    cf = "commit --amend --reuse-message HEAD";
    cp = "cherry-pick --ff";

    d = "diff";
    dom = "! git diff origin/$(git main)";

    f = "fetch";
    cl = "clone";
    pl = "pull";

    ir = "reset";
    irh = "reset --hard";
    irs = "reset --soft";
    irs1 = "reset --soft HEAD~1";

    lg = "!git log --topo-order --all --graph --pretty=format:\"%C(green)%h%C(reset) %s%C(red)%d%C(reset)%n\"";

    p = "push";
    pc = "!git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)";
    pf = "push --force-with-lease";

    r = "rebase";
    ra = "rebase --abort";
    rc = "rebase --continue";
    from = "! git fetch && git rebase origin/$(git main)";
    rom = "! git rebase origin/$(git main)";
    ri = "rebase --interactive";
    riom = "! git rebase --interactive origin/$(git main)";
    rs = "rebase --skip";

    s = "stash";
    sd = "stash show -p";
    sp = "stash pop";

    sh = "show";

    st = "status --short";

    sw = "switch";
  };
}
