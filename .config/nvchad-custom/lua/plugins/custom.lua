local plugins = {
  { "mbbill/undotree",
    lazy = false,
    config = function()
      require "configs.undotree"
    end,
  },
  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "nvimtools/none-ls.nvim",
      config = function()
        require "configs.null-ls"
      end,
    },

    config = function()
      require('nvchad.configs.lspconfig').defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "python-lsp-server",
        "marksman",
        "terraform-ls",
        "yaml-language-server",
        "bash-language-server",
        "beautysh",
        "shellcheck",
      },
    },
  },
  {
    "tpope/vim-fugitive",
    lazy = false,
    cmd = "Git",
    config = function()
      require "configs.fugitive"
    end,
  },
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
    keys = {
      { "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "make it rain" },
    },
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
