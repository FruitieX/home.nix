{ pkgs, ... }:

{
  enable = true;
  vimdiffAlias = true;
  viAlias = true;
  vimAlias = true;

  plugins = with pkgs.vimPlugins; [
    {
      plugin = catppuccin-nvim;
      type = "lua";
      config = ''
        require("catppuccin").setup({ flavour = "mocha" })
        vim.cmd.colorscheme "catppuccin"
      '';
    }
    vim-markdown
    vim-gitgutter
    vim-surround
    editorconfig-vim

    plenary-nvim
    {
      plugin = telescope-nvim;
      type = "lua";
      config = ''
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<C-p>', builtin.find_files)
        vim.keymap.set('n', '<leader>fg', builtin.live_grep)
        vim.keymap.set('n', '<leader>fb', builtin.buffers)
      '';
    }

    (nvim-treesitter.withPlugins (p: [
      p.bash p.json p.lua p.nix p.python
      p.rust p.toml p.typescript p.tsx p.yaml
      p.javascript p.html p.css p.markdown
    ]))
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
