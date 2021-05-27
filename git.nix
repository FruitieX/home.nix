{ pkgs, ... }:

{
  enable = true;

  userEmail = "rasmus@lovegren.fi";
  userName = "Rasmus Lövegren";

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
    a = "add";
    ap = "add --patch";

    b = "branch";
    bc = "checkout -b";
    bd = "branch --delete";

    c = "commit --verbose";
    ca = "commit --verbose --all";
    co = "checkout";
    com = "checkout master";
    cf = "commit --amend --reuse-message HEAD";
    cp = "cherry-pick --ff";

    d = "diff";
    dom = "diff origin/master";

    f = "fetch";
    cl = "clone";
    pl = "pull";

    ir = "reset";

    lg = "!git log --topo-order --all --graph --pretty=format:\"%C(green)%h%C(reset) %s%C(red)%d%C(reset)%n\"";

    p = "push";
    pc = "!git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)";
    pf = "push --force-with-lease";

    r = "rebase";
    ra = "rebase --abort";
    rc = "rebase --continue";
    from = "! git fetch && git rebase origin/master";
    rom = "rebase origin/master";
    ri = "rebase --interactive";
    riom = "rebase --interactive origin/master";
    rs = "rebase --skip";

    s = "stash";
    sd = "stash show -p";
    sp = "stash pop";

    sh = "show";

    st = "status --short";
  };
}