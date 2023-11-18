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
    'eandrju/cellular-automaton.nvim',
    cmd = "CellularAutomaton"
  },
}

return plugins
