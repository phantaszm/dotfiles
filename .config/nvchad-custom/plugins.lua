local plugins = {
  { "mbbill/undotree",
    lazy = false,
    config = function()
      require "custom.configs.undotree"
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "python-lsp-server",
        "marksman",
        "bash-language-server",
        "terraform-ls",
        "yaml-language-server",
      },
    },
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
    cmd = "Git",
    config = function()
      require "custom.configs.fugitive"
    end,
  },
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton"
  },
  {
    "lewis6991/spaceless.nvim",
    lazy = false,
    config = function()
      require'spaceless'.setup()
    end
  },
  {
    'echasnovski/mini.surround',
    version = '*',
    config = function()
      require('mini.surround').setup()
    end,
  },
  {
    'echasnovski/mini.align',
    version = '*',
    config = function()
      require('mini.align').setup()
    end,
  },
}

return plugins
