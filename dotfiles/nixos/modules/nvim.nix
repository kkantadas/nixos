{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    withNodeJs = true;
    withPython3 = true;

    plugins = with pkgs.vimPlugins; [
      nvim-tree-lua
      nvim-web-devicons
      nightfox-nvim
      telescope-nvim
      plenary-nvim
      nvim-treesitter
    ];

    initLua = ''
      require("kk.settings")
      require("kk.keymaps")
      require("kk.nvim-tree")
      require("kk.telescope")
      require("kk.colortheme")
    '';
  };

  xdg.configFile."nvim/lua/kk/settings.lua".text = ''
    vim.opt.number = true
    vim.opt.relativenumber = true
    vim.opt.termguicolors = true
    vim.opt.expandtab = true
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2

    vim.g.mapleader = " "
  '';

  xdg.configFile."nvim/lua/kk/keymaps.lua".text = ''
    vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", {
      noremap = true,
      silent = true,
      desc = "Toggle nvim-tree",
    })

    vim.keymap.set("n", "<Down>", "gj", {
      noremap = true,
      silent = true,
    })

    vim.keymap.set("n", "<Up>", "gk", {
      noremap = true,
      silent = true,
    })
  '';

  xdg.configFile."nvim/lua/kk/nvim-tree.lua".text = ''
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      view = {
        width = 30,
      },
      renderer = {
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
    })
  '';

  xdg.configFile."nvim/lua/kk/telescope.lua".text = ''
    require("telescope").setup({})
  '';

  xdg.configFile."nvim/lua/kk/colortheme.lua".text = ''
    vim.cmd("colorscheme nightfox")

    vim.cmd([[
      highlight Normal guibg=none
      highlight NonText guibg=none
      highlight Normal ctermbg=none
      highlight NonText ctermbg=none
    ]])
  '';
}
