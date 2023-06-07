{ pkgs, ... }:

{
  enable = true;
  vimdiffAlias = true;
  viAlias = true;
  vimAlias = true;

  plugins = with pkgs.vimPlugins; [
    base16-vim
    vim-markdown
    vim-gitgutter
    vim-surround
    editorconfig-vim
    ctrlp-vim
  ];
  extraConfig = ''
    " Sync clipboard with X11
    " set clipboard=unnamed

    " Force xclip usage for drastic startup time reduction
    let g:clipboard = {
        \   'name': 'xclip-custom',
        \   'copy': {
        \      '+': 'xclip -quiet -i -selection clipboard',
        \      '*': 'xclip -quiet -i -selection primary',
        \    },
        \   'paste': {
        \      '+': 'xclip -o -selection clipboard',
        \      '*': 'xclip -o -selection primary',
        \   },
        \ }

    " Restore cursor position
    function! ResCur()
        if line("'\"") <= line("$")
            normal! g`"
            return 1
        endif
    endfunction
    augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
    augroup END

    " Don't move the cursor after pasting
    " (by jumping to back start of previously changed text)
    noremap p p`[
    noremap P P`[

    " Keep 500 lines of command line history
    set history=500

    " Write persistent undo files
    set undofile
    set undodir=$HOME/.config/nvim/undo
    set undolevels=1000
    set undoreload=1000
  '';
}
